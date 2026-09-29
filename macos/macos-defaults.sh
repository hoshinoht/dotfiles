#!/usr/bin/env bash
# macOS developer defaults — idempotent, run anytime
# Some changes require logout/restart to take effect

set -euo pipefail
echo "Applying macOS defaults..."

# ── Keyboard ───────────────────────────────────────────
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# Holding a key repeats it instead of opening the accent picker.
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# ── Finder ─────────────────────────────────────────────
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# No .DS_Store on network shares (the USB variant no longer exists).
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# ── Screenshots ────────────────────────────────────────
mkdir -p ~/Pictures/screenshots
defaults write com.apple.screencapture location -string "$HOME/Pictures/screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
# Save immediately instead of after the floating-thumbnail preview.
defaults write com.apple.screencapture show-thumbnail -bool false

# ── Dock ───────────────────────────────────────────────
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock tilesize -int 43
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock launchanim -bool false
# Keep Spaces in a fixed order instead of by most recent use.
defaults write com.apple.dock mru-spaces -bool false

# ── Windows ────────────────────────────────────────────
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
# Ctrl-Cmd-drag moves a window from anywhere inside it.
defaults write NSGlobalDomain NSWindowShouldDragOnGesture -bool true
# Clicking the wallpaper does not sweep every window aside.
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# ── Spring-loaded directories ──────────────────────────
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

# ── Apply changes ──────────────────────────────────────
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo "Done. Some changes may require logout/restart."
