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
- Keep terminal experiments isolated: Fish may use a dedicated Starship config
  and launcher, while Ghostty's active theme and the Zsh prompt remain unchanged
  unless the user explicitly requests a global switch.
<!-- recall:lessons:end -->
