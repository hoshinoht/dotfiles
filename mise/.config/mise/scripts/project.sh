#!/usr/bin/env bash
set -Eeuo pipefail

action=${1:-}
shift || true
dry_run=${MISE_TASK_DRY_RUN:-0}

die() {
  printf 'project:%s: %s\n' "${action:-task}" "$*" >&2
  exit 2
}

print_command() {
  printf 'DRY RUN:'
  printf ' %q' "$@"
  printf '\n'
}

run_command() {
  if [[ "$dry_run" == 1 ]]; then
    print_command "$@"
  else
    "$@"
  fi
}

require_command() {
  [[ "$dry_run" == 1 ]] && return 0
  command -v "$1" >/dev/null 2>&1 \
    || die "required command is unavailable: $1 (run mise run bootstrap)"
}

project_dir=${MISE_ORIGINAL_CWD:-$PWD}
[[ -d "$project_dir" ]] || die "invocation directory does not exist: $project_dir"
cd "$project_dir"

manager=
lockfile=
search_dir=$project_dir
while :; do
  # Keep this order deliberate: a Python lockfile wins over JavaScript and Go
  # metadata when a repository contains more than one ecosystem.
  if [[ -f "$search_dir/uv.lock" ]]; then
    manager=uv
    lockfile="$search_dir/uv.lock"
  elif [[ -f "$search_dir/pnpm-lock.yaml" ]]; then
    manager=pnpm
    lockfile="$search_dir/pnpm-lock.yaml"
  elif [[ -f "$search_dir/bun.lock" ]]; then
    manager=bun
    lockfile="$search_dir/bun.lock"
  elif [[ -f "$search_dir/bun.lockb" ]]; then
    manager=bun
    lockfile="$search_dir/bun.lockb"
  elif [[ -f "$search_dir/package-lock.json" ]]; then
    manager=npm
    lockfile="$search_dir/package-lock.json"
  elif [[ -f "$search_dir/go.mod" ]]; then
    manager=go
    lockfile="$search_dir/go.mod"
  fi

  [[ -n "$manager" ]] && break
  [[ "$search_dir" == / ]] && break
  search_dir=${search_dir%/*}
  [[ -n "$search_dir" ]] || search_dir=/
done

[[ -n "$manager" ]] || die "unsupported project at $project_dir; expected uv.lock, pnpm-lock.yaml, bun.lock, bun.lockb, package-lock.json, or go.mod"
cd "${lockfile%/*}"

run_js_script() {
  local command=$1
  local script=$2
  shift 2
  require_command "$command"
  run_command "$command" run "$script" "$@"
}

run_uv_command() {
  require_command uv
  run_command uv run --locked -- "$@"
}

run_go_command() {
  local subcommand=$1
  shift
  require_command go
  local inherited_flags=${GOFLAGS:-}
  local goflags='-mod=readonly'
  [[ -n "$inherited_flags" ]] && goflags="$inherited_flags -mod=readonly"
  run_command env "GOTOOLCHAIN=auto" "GOFLAGS=$goflags" go "$subcommand" "$@"
}

setup() {
  case "$manager" in
    uv)
      require_command uv
      run_command uv sync --locked
      ;;
    pnpm)
      require_command pnpm
      run_command pnpm install --frozen-lockfile
      ;;
    bun)
      require_command bun
      run_command bun install --frozen-lockfile
      ;;
    npm)
      require_command npm
      run_command npm ci
      ;;
    go)
      # go mod download may add checksums to go.sum, so setup only verifies
      # the existing module cache and leaves go.mod/go.sum untouched.
      run_go_command mod verify
      ;;
  esac
}

check() {
  case "$manager" in
    uv)
      require_command uv
      if (($#)); then
        run_uv_command "$@"
      else
        run_command uv lock --check
      fi
      ;;
    pnpm)
      require_command pnpm
      run_command pnpm install --frozen-lockfile --dry-run
      ;;
    bun)
      require_command bun
      run_command bun install --frozen-lockfile --dry-run
      ;;
    npm)
      require_command npm
      run_command npm ci --dry-run
      ;;
    go)
      run_go_command mod verify
      ;;
  esac
}

dev() {
  case "$manager" in
    uv)
      (($#)) || die "uv project detected; pass the command after -- (for example: mise run project:dev -- python app.py)"
      run_uv_command "$@"
      ;;
    pnpm|bun|npm)
      run_js_script "$manager" dev "$@"
      ;;
    go)
      run_go_command run . "$@"
      ;;
  esac
}

test() {
  case "$manager" in
    uv)
      if (($#)); then
        run_uv_command "$@"
      else
        run_uv_command pytest
      fi
      ;;
    pnpm|bun|npm)
      run_js_script "$manager" test "$@"
      ;;
    go)
      run_go_command test ./... "$@"
      ;;
  esac
}

build() {
  case "$manager" in
    uv)
      require_command uv
      run_command uv build "$@"
      ;;
    pnpm|bun|npm)
      run_js_script "$manager" build "$@"
      ;;
    go)
      run_go_command build ./... "$@"
      ;;
  esac
}

case "$action" in
  setup|dev|test|check|build)
    "$action" "$@"
    ;;
  *)
    die "unknown action; expected setup, dev, test, check, or build"
    ;;
esac
