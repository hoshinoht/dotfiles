# Project guidance

<!-- recall:lessons:begin -->
## Design principles

- Treat Dusk and Dusk Darker as semantic color systems, not merely collections
  of reusable hex values. Preserve the established role mapping when changing
  layout: pink for OS/directory and the primary prompt, sky on a dark surface
  for Git, tool-specific accents for runtimes, muted overlays for secondary
  timing, and red for failures.
- Prompt experiments may change geometry, grouping, separators, or density,
  but must not redistribute the established color roles without explicit user
  approval. A new arrangement using the same palette can still violate the
  intended theme. Shape references should be translated structurally: merge
  conditional modules into one rail rather than detached pills, and derive any
  leading fade from the terminal canvas toward the destination role color so
  its final step matches that segment exactly.
- Keep Hoshino's modes visually distinct: Normal is a compact 6–9-row
  instrument rail (meters and a 24-hour day ruler), while Full uses a compact
  identity header and responsive system, context, and project bands with a
  metric table and stacked language bar. Actual Ghostty review is the visual
  gate; inset images need breathing room and closed rails. Labels stay muted
  while each value takes its role color as a whole, and a disk at 95% or more
  is flagged `▲ full` in warning yellow.
- Keep shell wiring isolated, but keep shared prompt visuals in the single
  Stow-managed Starship config so Zsh and Fish cannot drift. Ghostty launches
  Fish by default with automatic integration detection; changing the macOS
  account login shell remains a separate, explicit system action.
- Keep Hoshino one-shot output query-free and append-safe. Ratatui's inline
  viewport is forbidden because it issues a cursor-position query; the only
  reviewed one-shot graphics exception is bounded Kitty direct transfer with
  Unicode-placeholder rows and no cursor movement, raw mode, alternate screen,
  stdin read, or immediate deletion. Live alone owns terminal state/animation.
- Keep bounded project, coverage, and image reads behind Hoshino's shared
  atomic regular-file opener. Metadata checks followed by plain `File::open`
  reintroduce a FIFO-swap hang; Unix implicit reads require nonblocking,
  close-on-exec, no-follow opens followed by descriptor validation.
- Treat `tools/hoshino` as a standalone Cargo project rather than a Stow
  package or shared mise task. Installation and build artifacts stay local to
  that project even when the directory is represented by a Git submodule.
<!-- recall:lessons:end -->
