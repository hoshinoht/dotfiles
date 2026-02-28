# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Custom **"Dusk"** color theme inspired by Takanashi Hoshino from Blue Archive — her soft pinks and sky blues adapted for darker backgrounds. Built on top of Catppuccin Macchiato's base tones for contrast.

## Setup

```bash
brew install stow starship bat zoxide fd git-delta fastfetch
cd ~/.dotfiles && stow zsh git starship bat eza tmux ghostty fastfetch btop lazygit lazydocker fsh
```

## Packages

| Package | What it manages |
|---|---|
| `zsh` | `.zshrc` — oh-my-zsh, fzf, aliases, transient prompt |
| `starship` | Minimalist two-line prompt with Dusk palette |
| `bat` | Syntax highlighting with Dusk theme |
| `git` | `.gitconfig` with delta side-by-side diffs |
| `eza` | File listing colors (Dusk palette) |
| `tmux` | Statusline, keybinds, Dusk theme on Catppuccin dark base |
| `ghostty` | Terminal config + Dusk color scheme |
| `btop` | System monitor with Dusk theme |
| `lazygit` | Git TUI with Dusk border/selection colors |
| `lazydocker` | Docker TUI with Dusk border/selection colors |
| `fsh` | fast-syntax-highlighting Dusk theme for zsh |
| `fastfetch` | System info display |

## Dusk Palette

Built on Catppuccin Macchiato's dark base tones, with Hoshino-inspired pinks and sky blues.

### Accents

| Name | Hex | Preview |
|---|---|---|
| Rosewater | `#FCE4DE` | ![](https://img.shields.io/badge/%20%20-FCE4DE?style=flat-square&labelColor=FCE4DE) |
| Flamingo | `#F2BFB4` | ![](https://img.shields.io/badge/%20%20-F2BFB4?style=flat-square&labelColor=F2BFB4) |
| Pink | `#F3BDCA` | ![](https://img.shields.io/badge/%20%20-F3BDCA?style=flat-square&labelColor=F3BDCA) |
| Mauve | `#C4A2D4` | ![](https://img.shields.io/badge/%20%20-C4A2D4?style=flat-square&labelColor=C4A2D4) |
| Red | `#E27878` | ![](https://img.shields.io/badge/%20%20-E27878?style=flat-square&labelColor=E27878) |
| Maroon | `#E09898` | ![](https://img.shields.io/badge/%20%20-E09898?style=flat-square&labelColor=E09898) |
| Peach | `#DDA05C` | ![](https://img.shields.io/badge/%20%20-DDA05C?style=flat-square&labelColor=DDA05C) |
| Yellow | `#DEC47C` | ![](https://img.shields.io/badge/%20%20-DEC47C?style=flat-square&labelColor=DEC47C) |
| Green | `#82C8A0` | ![](https://img.shields.io/badge/%20%20-82C8A0?style=flat-square&labelColor=82C8A0) |
| Teal | `#6EC4B8` | ![](https://img.shields.io/badge/%20%20-6EC4B8?style=flat-square&labelColor=6EC4B8) |
| Sky | `#75D6F6` | ![](https://img.shields.io/badge/%20%20-75D6F6?style=flat-square&labelColor=75D6F6) |
| Sapphire | `#5CB8E4` | ![](https://img.shields.io/badge/%20%20-5CB8E4?style=flat-square&labelColor=5CB8E4) |
| Blue | `#68ACE0` | ![](https://img.shields.io/badge/%20%20-68ACE0?style=flat-square&labelColor=68ACE0) |
| Lavender | `#B0BCE8` | ![](https://img.shields.io/badge/%20%20-B0BCE8?style=flat-square&labelColor=B0BCE8) |

### Text & Surfaces

| Name | Hex | Preview |
|---|---|---|
| Text | `#F3F5FC` | ![](https://img.shields.io/badge/%20%20-F3F5FC?style=flat-square&labelColor=F3F5FC) |
| Subtext 1 | `#D2D5DE` | ![](https://img.shields.io/badge/%20%20-D2D5DE?style=flat-square&labelColor=D2D5DE) |
| Subtext 0 | `#B2B6C1` | ![](https://img.shields.io/badge/%20%20-B2B6C1?style=flat-square&labelColor=B2B6C1) |
| Overlay 2 | `#8F939F` | ![](https://img.shields.io/badge/%20%20-8F939F?style=flat-square&labelColor=8F939F) |
| Overlay 1 | `#7E828F` | ![](https://img.shields.io/badge/%20%20-7E828F?style=flat-square&labelColor=7E828F) |
| Overlay 0 | `#6E7280` | ![](https://img.shields.io/badge/%20%20-6E7280?style=flat-square&labelColor=6E7280) |
| Surface 2 | `#60646E` | ![](https://img.shields.io/badge/%20%20-60646E?style=flat-square&labelColor=60646E) |
| Surface 1 | `#52565F` | ![](https://img.shields.io/badge/%20%20-52565F?style=flat-square&labelColor=52565F) |
| Surface 0 | `#454850` | ![](https://img.shields.io/badge/%20%20-454850?style=flat-square&labelColor=454850) |
| Base | `#393C43` | ![](https://img.shields.io/badge/%20%20-393C43?style=flat-square&labelColor=393C43) |
| Mantle | `#2F3238` | ![](https://img.shields.io/badge/%20%20-2F3238?style=flat-square&labelColor=2F3238) |
| Crust | `#26282D` | ![](https://img.shields.io/badge/%20%20-26282D?style=flat-square&labelColor=26282D) |
