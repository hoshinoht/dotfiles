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
| Rosewater | `#FCE4DE` | ![](palette/rosewater.svg) |
| Flamingo | `#F2BFB4` | ![](palette/flamingo.svg) |
| Pink | `#F3BDCA` | ![](palette/pink.svg) |
| Mauve | `#C4A2D4` | ![](palette/mauve.svg) |
| Red | `#E27878` | ![](palette/red.svg) |
| Maroon | `#E09898` | ![](palette/maroon.svg) |
| Peach | `#DDA05C` | ![](palette/peach.svg) |
| Yellow | `#DEC47C` | ![](palette/yellow.svg) |
| Green | `#82C8A0` | ![](palette/green.svg) |
| Teal | `#6EC4B8` | ![](palette/teal.svg) |
| Sky | `#75D6F6` | ![](palette/sky.svg) |
| Sapphire | `#5CB8E4` | ![](palette/sapphire.svg) |
| Blue | `#68ACE0` | ![](palette/blue.svg) |
| Lavender | `#B0BCE8` | ![](palette/lavender.svg) |

### Text & Surfaces

| Name | Hex | Preview |
|---|---|---|
| Text | `#F3F5FC` | ![](palette/text.svg) |
| Subtext 1 | `#D2D5DE` | ![](palette/subtext1.svg) |
| Subtext 0 | `#B2B6C1` | ![](palette/subtext0.svg) |
| Overlay 2 | `#8F939F` | ![](palette/overlay2.svg) |
| Overlay 1 | `#7E828F` | ![](palette/overlay1.svg) |
| Overlay 0 | `#6E7280` | ![](palette/overlay0.svg) |
| Surface 2 | `#60646E` | ![](palette/surface2.svg) |
| Surface 1 | `#52565F` | ![](palette/surface1.svg) |
| Surface 0 | `#454850` | ![](palette/surface0.svg) |
| Base | `#393C43` | ![](palette/base.svg) |
| Mantle | `#2F3238` | ![](palette/mantle.svg) |
| Crust | `#26282D` | ![](palette/crust.svg) |
