#!/usr/bin/env bash
set -Eeuo pipefail

usage() {
  cat <<'EOF'
Usage: ./bootstrap.sh [--dry-run|--check]

Install the Homebrew bundle, shell/editor dependencies, and dotfile links.
--dry-run and --check perform read-only checks and Stow simulation only.
Set INSTALL_TMUX_PLUGINS=0 to skip TPM plugin installation.
EOF
}

die() {
  printf 'bootstrap: error: %s\n' "$*" >&2
  exit 1
}

warn() {
  printf 'bootstrap: warning: %s\n' "$*" >&2
}

log() {
  printf 'bootstrap: %s\n' "$*"
}

DRY_RUN="${BOOTSTRAP_DRY_RUN:-0}"
case "${1:-}" in
  --dry-run|--check|--check-only)
    DRY_RUN=1
    shift
    ;;
  --help|-h)
    usage
    exit 0
    ;;
esac
[[ $# -eq 0 ]] || die "unexpected argument: $1 (use --help for usage)"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
BREWFILE="$REPO_ROOT/Brewfile"
STOW_PACKAGES=(
  zsh git mise nvim zed starship bat eza tmux ghostty fastfetch btop
  lazygit lazydocker fsh yazi aerospace
)

[[ "$(uname -s)" == "Darwin" ]] || die "macOS is required"
[[ -n "${HOME:-}" && "$HOME" != "/" ]] || die "HOME must point to a user home directory"
[[ -f "$BREWFILE" ]] || die "missing Brewfile: $BREWFILE"

BREW="$(command -v brew || true)"
[[ -n "$BREW" ]] || die "Homebrew is required; install it before running bootstrap"
"$BREW" --version >/dev/null 2>&1 || die "Homebrew is not runnable: $BREW"

for package in "${STOW_PACKAGES[@]}"; do
  [[ -d "$REPO_ROOT/$package" ]] || die "missing Stow package: $REPO_ROOT/$package"
done

check_brewfile() {
  local cache_dir
  local check_status

  # Bundle check may download Homebrew API metadata. Keep that read-only
  # validation in a disposable cache so dry-run does not alter the user's brew state.
  cache_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-brew-check.XXXXXX")"
  if HOMEBREW_CACHE="$cache_dir" HOMEBREW_NO_AUTO_UPDATE=1 \
    "$BREW" bundle check --file "$BREWFILE" --verbose; then
    check_status=0
  else
    check_status=$?
  fi
  rm -rf "$cache_dir"
  return "$check_status"
}

if [[ "$DRY_RUN" == 1 ]]; then
  log "dry-run: checking Brewfile dependencies"
  if ! check_brewfile; then
    warn "Brewfile dependencies are not all installed; continuing without changes"
  fi
else
  log "installing Homebrew bundle without upgrades"
  HOMEBREW_NO_AUTO_UPDATE=1 "$BREW" bundle install --no-upgrade --file "$BREWFILE"
fi

ensure_command() {
  local command_name="$1"
  if ! command -v "$command_name" >/dev/null 2>&1; then
    if [[ "$DRY_RUN" == 1 ]]; then
      warn "dry-run: command not currently available: $command_name"
    else
      die "required command is unavailable after Homebrew setup: $command_name"
    fi
  fi
}

ensure_command git
ensure_command stow

ensure_clone() {
  local name="$1"
  local url="$2"
  local destination="$3"
  local parent

  if [[ -d "$destination/.git" ]]; then
    log "$name already present: $destination"
    return 0
  fi

  if [[ -e "$destination" || -L "$destination" ]]; then
    die "$name path exists but is not a Git checkout: $destination; move it aside or back it up, then rerun"
  fi

  parent="$(dirname "$destination")"
  if [[ -e "$parent" && ! -d "$parent" ]]; then
    die "cannot create $name because its parent is not a directory: $parent; back it up and rerun"
  fi

  if [[ "$DRY_RUN" == 1 ]]; then
    log "dry-run: would clone $name from $url into $destination"
    return 0
  fi

  mkdir -p "$parent"
  log "cloning $name"
  GIT_TERMINAL_PROMPT=0 git clone --depth=1 "$url" "$destination"
}

ensure_clone "Oh My Zsh" \
  "https://github.com/ohmyzsh/ohmyzsh.git" \
  "$HOME/.oh-my-zsh"
ensure_clone "fzf-tab" \
  "https://github.com/Aloxaf/fzf-tab.git" \
  "$HOME/.oh-my-zsh/custom/plugins/fzf-tab"
ensure_clone "zsh-autosuggestions" \
  "https://github.com/zsh-users/zsh-autosuggestions.git" \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
ensure_clone "fast-syntax-highlighting" \
  "https://github.com/zdharma-continuum/fast-syntax-highlighting.git" \
  "$HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting"
ensure_clone "TPM" \
  "https://github.com/tmux-plugins/tpm.git" \
  "$HOME/.tmux/plugins/tpm"

run_stow() {
  local stow_output
  local stow_status
  local stow_args=(
    --verbose
    --ignore='\.DS_Store$'
    --target="$HOME"
    "${STOW_PACKAGES[@]}"
  )

  log "simulating Stow links"
  set +e
  stow_output="$(cd "$REPO_ROOT" && stow --simulate --no-folding "${stow_args[@]}" 2>&1)"
  stow_status=$?
  set -e
  printf '%s\n' "$stow_output"

  if [[ $stow_status -ne 0 ]]; then
    die "Stow found an existing directory/config collision; no files were deleted. Back up or move the conflicting target, then rerun (see the Stow output above)"
  fi

  if [[ "$DRY_RUN" == 1 ]]; then
    log "dry-run: skipping Stow links"
    return 0
  fi

  log "stowing packages"
  if ! (cd "$REPO_ROOT" && stow --no-folding "${stow_args[@]}"); then
    die "Stow refused to link the packages; no files were deleted. Back up or move the conflicting target, then rerun"
  fi
}

run_stow

if [[ "$DRY_RUN" == 1 ]]; then
  log "dry-run: would run mise install"
  log "dry-run: would run mise run python:install"
else
  ensure_command mise
  log "installing configured mise tools"
  (cd "$REPO_ROOT" && mise install)
  log "installing the default uv-managed Python"
  (cd "$REPO_ROOT" && mise run python:install)
fi

if [[ "$DRY_RUN" == 1 ]]; then
  log "dry-run: would build the bat cache"
else
  ensure_command bat
  log "building bat cache"
  bat cache --build
fi

if [[ "${INSTALL_TMUX_PLUGINS:-1}" == 0 ]]; then
  log "skipping tmux plugin installation (INSTALL_TMUX_PLUGINS=0)"
elif [[ ! -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]]; then
  warn "TPM installer is unavailable; skipping tmux plugins"
elif [[ "$DRY_RUN" == 1 ]]; then
  log "dry-run: would install tmux plugins through TPM"
else
  log "installing tmux plugins through TPM"
  if ! TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins" \
    "$HOME/.tmux/plugins/tpm/bin/install_plugins"; then
    warn "TPM plugin installation failed; rerun the TPM installer when network access is available"
  fi
fi

log "bootstrap complete"
