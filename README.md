# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Custom **"Dusk"** color theme inspired by Takanashi Hoshino from Blue Archive — her soft pinks and sky blues adapted for darker backgrounds. Built on top of Catppuccin Macchiato's base tones for contrast.

## Setup

```bash
brew install stow starship bat zoxide fd git-delta fastfetch
cd ~/.dotfiles && stow zsh git starship bat eza tmux ghostty fastfetch
```

## Packages

| Package | What it manages |
|---|---|
| `zsh` | `.zshrc` — oh-my-zsh, fzf, aliases, transient prompt |
| `starship` | Minimalist two-line prompt with Dusk palette |
| `bat` | Syntax highlighting with Catppuccin theme |
| `git` | `.gitconfig` with delta side-by-side diffs |
| `eza` | File listing colors (Dusk palette) |
| `tmux` | Statusline, keybinds, Dusk theme on Catppuccin dark base |
| `ghostty` | Terminal config + Dusk color scheme |
| `fastfetch` | System info display |
