# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

Custom **Dusk** color themes inspired by Takanashi Hoshino from Blue Archive.
The original keeps its soft pink and sky-blue palette; **Dusk Darker** raises
contrast and deepens the surfaces for daily use.

## Setup

Homebrew must already be installed on macOS. From a checkout at
`~/.dotfiles`, run the canonical, idempotent entry point:

```bash
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` installs the tracked [Brewfile](Brewfile) with no upgrades or
cleanup, initializes Oh My Zsh plugins and TPM when they are absent, links
the 17 Stow packages with `--no-folding`, installs the configured mise tools
and default Python, builds the bat cache, and may install tmux plugins. It
does not change the login shell (`chsh`) or remove packages. Set
`INSTALL_TMUX_PLUGINS=0` to skip optional TPM plugin installation.

Use either read-only mode to inspect a machine before changing it:

```bash
./bootstrap.sh --check
./bootstrap.sh --dry-run
```

Both modes check the Brewfile and simulate Stow without cloning, linking,
installing, or changing package state. After setup, these diagnostics are
available from the globally Stowed mise tasks:

```bash
mise run doctor
mise run check
```

## Homebrew inventory

`Brewfile` declares direct dependencies only. Formulae are `neovim` (the
stable Homebrew formula), `stow`, `mise`, `fzf`, `fd`, `ripgrep`, `bat`, `eza`,
`zoxide`, `starship`, `tmux`, `yazi`, `btop`, `lazygit`, `lazydocker`, `gh`,
`git`, `git-delta`, `git-lfs`, and `fastfetch`. Casks are AeroSpace (from its
trusted tap), Ghostty, OrbStack, Raycast, Zed, Blex Mono Nerd Font, and
JetBrains Mono Nerd Font. Oh My Zsh, fzf-tab, zsh-autosuggestions,
fast-syntax-highlighting, and TPM are initialized by `bootstrap.sh` rather
than declared as Homebrew packages.

## Stow packages

The bootstrap links these packages into `$HOME` with `--no-folding`:

| Package | What it manages |
|---|---|
| `zsh` | `.zshrc`, Oh My Zsh integration, aliases, fzf, and the transient prompt |
| `git` | `.gitconfig`, Delta, GitHub CLI browsing, and worktree aliases |
| `mise` | Runtime pins, environment activation, and global/project tasks |
| `nvim` | LazyVim-based Neovim configuration and local Dusk themes |
| `zed` | Durable Zed settings, keymap, and local Dusk themes |
| `starship` | Rail prompt with selectable Dusk palettes |
| `bat` | Syntax highlighting with Dusk and Dusk Darker themes |
| `eza` | File-listing colors through the selected Dusk theme directory |
| `tmux` | Prefix, pane/TUI bindings, statusline, and selectable themes |
| `ghostty` | Terminal settings, themes, and the Darker launcher |
| `fastfetch` | System information display |
| `btop` | System monitor with Dusk themes |
| `lazygit` | Git TUI colors |
| `lazydocker` | Container TUI colors |
| `fsh` | fast-syntax-highlighting themes for both Dusk variants |
| `yazi` | File manager flavor and syntax theme |
| `aerospace` | AeroSpace tiling window-manager configuration |

## Runtime ownership

[`mise/.config/mise/config.toml`](mise/.config/mise/config.toml) owns the
global development tools and keeps their versions explicit:

| Tool | Owner and version |
|---|---|
| Node | mise `24.21.0` |
| pnpm | mise `11.17.0` |
| Bun | mise `1.4.0` |
| Go | mise `1.27.1`, with `GOTOOLCHAIN=auto` |
| uv | mise `0.12.12` |
| Python | uv, installed by `mise run python:install` as `3.14.7` |
| Rust | rustup (unchanged) |

mise activation is loaded by `.zshrc`. Node project version files are read
conservatively; Go module requirements remain module requirements rather than
global pins. A Homebrew Node may remain as another package's dependency, but it
does not own the active PATH.

direnv is intentionally absent: the final scan found no user `.envrc` files,
so the old hook and formula were removed. Use mise environment features for
project-specific environment settings instead.

## mise tasks and project detection

Global tasks are defined under
[`mise/.config/mise/tasks`](mise/.config/mise/tasks):

| Task | Purpose |
|---|---|
| `mise run bootstrap` | Install configured mise tools and default Python |
| `mise run doctor` | Run mise diagnostics and show global tools without installing them |
| `mise run check` | Validate pins, settings, and discoverable global tasks |
| `mise run python:install` | Install uv-managed Python `3.14.7` as the default |
| `mise run project:setup` | Install or verify project dependencies from its first supported lockfile |
| `mise run project:dev` | Run the project development command |
| `mise run project:test` | Run the project test command |
| `mise run project:check` | Validate project metadata without changing lockfiles |
| `mise run project:build` | Run the project build command |

Project helpers search from the current directory upward in this order:
`uv.lock`, `pnpm-lock.yaml`, `bun.lock`/`bun.lockb`, `package-lock.json`, then
`go.mod`. Detection is read-only and never rewrites lockfiles. Setup uses
locked/frozen installs (or Go module verification); `project:dev` for a uv
project takes an explicit command, for example
`mise run project:dev -- python app.py`.

## Editors and themes

Neovim is the Homebrew stable formula with a LazyVim-based configuration.
Zed's durable settings and keymap are managed separately from its prompt
database and other runtime state, which remain intentionally unmanaged. Both
editors include local **Dusk** and **Dusk Darker** themes, with **Dusk Darker**
as the default and Space as the leader in Neovim and Zed.

### Active theme: Dusk Darker

`dusk-darker` is selected by default throughout the terminal stack. The
original `dusk` definitions remain available alongside it. Ghostty can open a
separate Darker instance that quits after its last window closes:

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

## Key ownership

Bindings are deliberately assigned by layer rather than duplicated:

| Layer | Ownership and notable bindings |
|---|---|
| AeroSpace | `Alt` focuses with `h/j/k/l`, moves with `Alt-Shift-h/j/k/l`, and selects workspaces with `Alt-1` through `Alt-9` |
| tmux | `Ctrl-Space` is the prefix; pressing it twice sends a literal prefix to the pane. `prefix+r` reloads; `prefix+g/d/b/y` opens lazygit/lazydocker/btop/yazi popups |
| fzf | Native shell integration keeps `Ctrl-T` for file selection |
| Neovim / Zed | Space is the leader; Zed's managed normal-mode shortcuts include `Space-f`, `Space-s`, `Space-p`, `Space-d`, and `Space-g` |
| TUIs | Native TUI keybindings remain available inside lazygit, lazydocker, btop, and yazi |
| Ghostty | `Cmd-D` opens a right-hand split |

## Git and worktrees

Git keeps the useful Delta side-by-side pager, lazygit, and `nvimdiff`
mergetool/difftool integration. The safer interactive staging alias is
`git a` (`add --interactive`), and `git open` delegates repository browsing
to `gh browse`. The default initial branch is `main`.

The native worktree aliases are intentionally small and inspectable:

| Command | Effect |
|---|---|
| `git wtl` | `git worktree list` |
| `git wtp` | `git worktree prune --dry-run` |

`git wtp` is a dry run; it does not prune anything.

## Containers

OrbStack remains the container engine and supplies the Docker CLI/daemon. The
active Docker context is `orbstack`; the `lazydocker` TUI and Docker shell
plugins use it. Homebrew `buildx` may still be present as a dependency/tool,
but it is not the engine. Apple container is intentionally not adopted.

## Migration backup and rollback

The completed migration retained these external backups:

- Editor configuration: `~/Library/Application Support/dotfiles-backups/editor-configs-20260911`
- Legacy Python virtual environments: `~/Library/Application Support/dotfiles-backups/python-venvs-20260911`

Editor files were backed up before selective Stow adoption. Legacy venvs were
archived with manifests and checksums; environments with usable requirements
were rebuilt with uv. Python.org 3.13 was removed only after references were
cleared.

To roll back a managed config, remove the relevant Stow links (or run Stow's
package-specific uninstall) and restore the corresponding editor files from
the backup directory. Leave Zed prompt/runtime state untouched. Archived venvs
are recovery material, not guaranteed-portable environments: use their
retained manifests and archives to rebuild with a compatible interpreter.

## Intentional exclusions

- No Homebrew-owned Node, pnpm, Bun, Go, or uv installation is required; mise owns the configured versions. A transitive Homebrew Node is harmless but does not own PATH.
- No direnv, Apple container, package cleanup, or `chsh` is performed.
- Rust remains owned by rustup.
- Application repositories, Zed prompt/runtime databases, and unknown user data are outside this repository's management.
- The machine-local `reika` wrapper in `.zshrc` is retained as a pre-existing user customization; bootstrap does not install its target binary.

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
