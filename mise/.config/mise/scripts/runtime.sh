#!/usr/bin/env bash
set -Eeuo pipefail

action=${1:-}
shift || true
dry_run=${MISE_TASK_DRY_RUN:-0}
script_dir=$(cd -- "$(dirname -- "$0")" && pwd)
config_root=${MISE_DOTFILES_CONFIG_ROOT:-$(cd -- "$script_dir/.." && pwd)}

die() {
  printf 'mise %s: %s\n' "${action:-task}" "$*" >&2
  exit 1
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
  command -v "$1" >/dev/null 2>&1 || die "required command is unavailable: $1 (run mise run bootstrap)"
}

bootstrap() {
  require_command mise
  run_command mise install
  run_command mise run python:install
}

doctor() {
  require_command mise
  printf 'mise: '
  mise --version
  printf 'config: %s\n' "$config_root"
  mise doctor "$@"
  mise ls --global
}

check() {
  require_command mise
  local config_file="$config_root/config.toml"
  local task_names
  local expected tool version actual
  local -a expected_tasks=(
    bootstrap
    doctor
    check
    project:setup
    project:dev
    project:test
    project:check
    project:build
    python:install
  )
  local -a expected_tools=(
    'uv=0.12.12'
    'node=24.21.0'
    'pnpm=11.17.0'
    'bun=1.4.0'
    'go=1.27.1'
  )

  [[ -f "$config_file" ]] || die "config file not found: $config_file"
  grep -Fq 'idiomatic_version_file_enable_tools = ["node"]' "$config_file" \
    || die "Node idiomatic version-file support is not configured conservatively"
  grep -Fq 'GOTOOLCHAIN = "auto"' "$config_file" \
    || die "GOTOOLCHAIN=auto is not configured"
  grep -Fq 'run = "uv python install 3.14.7 --default"' "$config_file" \
    || die "uv-managed Python 3.14.7 install task is not preserved"

  task_names=$(mise tasks --global --no-header --name-only)
  for expected in "${expected_tasks[@]}"; do
    grep -Fxq "$expected" <<<"$task_names" \
      || die "global task is not discoverable: $expected"
  done

  for expected in "${expected_tools[@]}"; do
    tool=${expected%%=*}
    version=${expected#*=}
    actual=$(mise tool "$tool" --requested 2>/dev/null || true)
    [[ "$actual" == "$version" ]] \
      || die "$tool is requested at $actual, expected $version"
  done

  [[ "${GOTOOLCHAIN:-}" == auto ]] \
    || die "GOTOOLCHAIN is ${GOTOOLCHAIN:-unset}, expected auto"
  printf 'mise configuration and public tasks are valid\n'
}

case "$action" in
  bootstrap|doctor|check)
    "$action" "$@"
    ;;
  *)
    die "unknown action; expected bootstrap, doctor, or check"
    ;;
esac
