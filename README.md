# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Custom **Dusk** color themes inspired by Takanashi Hoshino from Blue Archive.
The original keeps its soft pink and sky-blue palette; **Dusk Darker** raises
contrast and deepens the surfaces for daily use.

## Setup

```bash
brew install stow starship bat zoxide fd git-delta fastfetch
cd ~/.dotfiles && stow zsh git starship bat eza tmux ghostty fastfetch btop lazygit lazydocker fsh
```

### Active theme: Dusk Darker

that quits after its last window closes, run:
`dusk-darker` is selected by default throughout the terminal stack. The
original `dusk` definitions remain available alongside it. Ghostty can open a
separate Darker instance that quits after its last window closes:
that quits after its last window closes, run:

```bash
~/.config/ghostty/launch-dusk-darker
```

Named variants are selected in each tool's normal configuration: Starship's
`palette`, Ghostty and btop's `theme`, bat and Delta's syntax theme, Yazi's
dark flavor, the FSH theme, the eza config directory, and tmux's statusline
selector. The lazy TUIs, Fastfetch, and fzf use the active Darker colors
directly because they do not expose a comparable named-theme selector.

To return an individual tool to original Dusk, change its active selector:

| Tool | Dusk Darker | Original Dusk |
|---|---|---|
| Ghostty | `theme = dusk-darker` | `theme = dusk` |
| Starship | `palette = "dusk-darker"` | `palette = "dusk"` |
| bat / Delta | `Dusk Darker` | `Dusk` |
| btop | `color_theme = "dusk-darker"` | `color_theme = "dusk"` |
| fast-syntax-highlighting | `fast-theme -q dusk-darker` | `fast-theme -q dusk` |
| Yazi | `dark = "dusk-darker"` | `dark = "dusk"` |
| eza | `~/.config/eza/themes/dusk-darker` | `~/.config/eza` |
| tmux | `statusline-dusk-darker.conf` | `statusline-dusk.conf` |

After changing bat themes, run `bat cache --build`. Start a new shell after
changing Starship, eza, or fast-syntax-highlighting; reload tmux with
`prefix+r` after changing its statusline selector.

## Packages

| Package | What it manages |
|---|---|
| `zsh` | `.zshrc` — oh-my-zsh, fzf, aliases, transient prompt |
| `starship` | Rail prompt with selectable Dusk palettes |
| `bat` | Syntax highlighting with Dusk and Dusk Darker themes |
| `git` | `.gitconfig` with delta side-by-side diffs |
| `eza` | File listing colors (Dusk palette) |
| `tmux` | Statusline, keybinds, and selectable Dusk statusline themes |
| `ghostty` | Terminal config plus Dusk and Dusk Darker color schemes |
| `btop` | System monitor with Dusk and Dusk Darker themes |
| `lazygit` | Git TUI with Dusk border/selection colors |
| `lazydocker` | Docker TUI with Dusk border/selection colors |
| `fsh` | fast-syntax-highlighting themes for both Dusk variants |
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

## Dusk Darker Palette

Dusk Darker retains the original identity while increasing separation between
text, inactive content, selections, and the near-black canvas.

### Accents

| Name | Hex | Preview |
|---|---|---|
| Rosewater | `#FFD4E2` | ![](palette/dusk-darker/rosewater.svg) |
| Flamingo | `#FFD0DF` | ![](palette/dusk-darker/flamingo.svg) |
| Pink | `#FFB8D1` | ![](palette/dusk-darker/pink.svg) |
| Mauve | `#C4A2D4` | ![](palette/dusk-darker/mauve.svg) |
| Red | `#FF8F9A` | ![](palette/dusk-darker/red.svg) |
| Maroon | `#FFA3AC` | ![](palette/dusk-darker/maroon.svg) |
| Peach | `#DDA05C` | ![](palette/dusk-darker/peach.svg) |
| Yellow | `#F4DA86` | ![](palette/dusk-darker/yellow.svg) |
| Green | `#9BE6B5` | ![](palette/dusk-darker/green.svg) |
| Teal | `#78E1D0` | ![](palette/dusk-darker/teal.svg) |
| Sky | `#8BD3FF` | ![](palette/dusk-darker/sky.svg) |
| Sapphire | `#91ECF1` | ![](palette/dusk-darker/sapphire.svg) |
| Blue | `#7BC1F2` | ![](palette/dusk-darker/blue.svg) |
| Lavender | `#B0BCE8` | ![](palette/dusk-darker/lavender.svg) |

### Text & Surfaces

| Name | Hex | Preview |
|---|---|---|
| Text | `#FFFFFF` | ![](palette/dusk-darker/text.svg) |
| Subtext 1 | `#E6E9F2` | ![](palette/dusk-darker/subtext1.svg) |
| Subtext 0 | `#C6CBD6` | ![](palette/dusk-darker/subtext0.svg) |
| Overlay 2 | `#A6ADBB` | ![](palette/dusk-darker/overlay2.svg) |
| Overlay 1 | `#858B9C` | ![](palette/dusk-darker/overlay1.svg) |
| Overlay 0 | `#697080` | ![](palette/dusk-darker/overlay0.svg) |
| Surface 2 | `#52617A` | ![](palette/dusk-darker/surface2.svg) |
| Surface 1 | `#414B5E` | ![](palette/dusk-darker/surface1.svg) |
| Surface 0 | `#333B4B` | ![](palette/dusk-darker/surface0.svg) |
| Base | `#272D39` | ![](palette/dusk-darker/base.svg) |
| Mantle | `#20242E` | ![](palette/dusk-darker/mantle.svg) |
| Crust | `#171A22` | ![](palette/dusk-darker/crust.svg) |
