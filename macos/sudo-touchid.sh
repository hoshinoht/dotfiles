#!/usr/bin/env bash
# Touch ID for sudo, including inside tmux — idempotent, run anytime.
# Writes /etc/pam.d/sudo_local, which /etc/pam.d/sudo includes and macOS
# updates leave alone. pam_reattach (Brewfile) reattaches tmux panes to the
# GUI session so pam_tid can show the prompt; ignore_ssh keeps real SSH
# logins on password auth.

set -euo pipefail

REATTACH=/opt/homebrew/lib/pam/pam_reattach.so
TARGET=/etc/pam.d/sudo_local

[[ -f "$REATTACH" ]] || { echo "missing $REATTACH: brew install pam-reattach" >&2; exit 1; }

desired="# sudo_local: managed by ~/.dotfiles/macos/sudo-touchid.sh
auth       optional       $REATTACH ignore_ssh
auth       sufficient     pam_tid.so"

if [[ -f "$TARGET" ]] && [[ "$(cat "$TARGET")" == "$desired" ]]; then
  echo "Touch ID for sudo already configured."
  exit 0
fi

printf '%s\n' "$desired" | sudo tee "$TARGET" >/dev/null
sudo chmod 444 "$TARGET"
echo "Touch ID for sudo configured in $TARGET."
