# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Catppuccin Macchiato everywhere.

## Setup

```bash
brew install stow starship bat zoxide fd git-delta fastfetch
cd ~/.dotfiles && stow zsh git starship bat eza tmux ghostty fastfetch
```

## Packages

| Package | What it manages |
|---|---|
| `zsh` | `.zshrc` — oh-my-zsh, fzf, aliases, transient prompt |
| `starship` | Two-line prompt with Catppuccin Macchiato palette |
| `bat` | Syntax highlighting with Catppuccin theme |
| `git` | `.gitconfig` with delta side-by-side diffs |
| `eza` | File listing colors (Catppuccin Macchiato) |
| `tmux` | Statusline, keybinds, Catppuccin Macchiato theme |
| `ghostty` | Terminal config + shaders |
| `fastfetch` | System info display |
