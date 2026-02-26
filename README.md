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

## Dusk Palette

Built on Catppuccin Macchiato's dark base tones, with Hoshino-inspired pinks and sky blues.

### Accents

| Name | Hex | Preview |
|---|---|---|
| Pink | `#F3BDCA` | ![](https://via.placeholder.com/16/F3BDCA/F3BDCA) |
| Sky | `#75D6F6` | ![](https://via.placeholder.com/16/75D6F6/75D6F6) |
| Lavender | `#B0BCE8` | ![](https://via.placeholder.com/16/B0BCE8/B0BCE8) |
| Mauve | `#C4A2D4` | ![](https://via.placeholder.com/16/C4A2D4/C4A2D4) |
| Peach | `#DDA05C` | ![](https://via.placeholder.com/16/DDA05C/DDA05C) |
| Yellow | `#DEC47C` | ![](https://via.placeholder.com/16/DEC47C/DEC47C) |
| Green | `#82C8A0` | ![](https://via.placeholder.com/16/82C8A0/82C8A0) |
| Teal | `#6EC4B8` | ![](https://via.placeholder.com/16/6EC4B8/6EC4B8) |
| Red | `#E27878` | ![](https://via.placeholder.com/16/E27878/E27878) |

### Text & Surfaces

| Name | Hex | Preview |
|---|---|---|
| Text | `#F3F5FC` | ![](https://via.placeholder.com/16/F3F5FC/F3F5FC) |
| Subtext 1 | `#D2D5DE` | ![](https://via.placeholder.com/16/D2D5DE/D2D5DE) |
| Subtext 0 | `#B2B6C1` | ![](https://via.placeholder.com/16/B2B6C1/B2B6C1) |
| Overlay 2 | `#8F939F` | ![](https://via.placeholder.com/16/8F939F/8F939F) |
| Overlay 1 | `#7E828F` | ![](https://via.placeholder.com/16/7E828F/7E828F) |
| Surface 2 | `#60646E` | ![](https://via.placeholder.com/16/60646E/60646E) |
| Surface 1 | `#52565F` | ![](https://via.placeholder.com/16/52565F/52565F) |
| Surface 0 | `#454850` | ![](https://via.placeholder.com/16/454850/454850) |
| Base | `#393C43` | ![](https://via.placeholder.com/16/393C43/393C43) |
| Mantle | `#2F3238` | ![](https://via.placeholder.com/16/2F3238/2F3238) |
| Crust | `#26282D` | ![](https://via.placeholder.com/16/26282D/26282D) |
