# Goal

Deliver a reproducible, themed macOS development environment with mise-owned runtimes, safely managed editor configuration, modern Git worktrees, coherent keybindings, and evidence-backed bootstrap documentation.

## Scope and non-goals

In scope: Node/pnpm/Bun/Go/uv/Python ownership, unused direnv removal, reversible legacy Python cleanup, standard mise tasks, Neovim and Zed with Dusk themes, Git/worktree helpers, terminal/editor keybindings, a curated Brewfile, bootstrap documentation, and validation.

Out of scope: changing OrbStack, re-adopting Apple container, replacing rustup, editing application repositories, committing or publishing, and deleting unknown user data.

## Authorization, decisions and assumptions

- Implementation and necessary machine changes are explicitly authorized by the user.
- Existing README, Zsh, mise, and fast-syntax-highlighting work is protected user work and must be integrated rather than replaced.
- Node 24 LTS is the global default; project-native version metadata may override it.
- Go 1.27.1 is the global default; Go's `GOTOOLCHAIN=auto` remains available for module requirements.
- uv owns Python; rustup owns Rust; mise owns the other selected runtimes. Bun remains available but moves under mise.
- No user-project `.envrc` currently exists, so direnv can be removed after one final scan.
- AeroSpace keeps `Alt`; tmux moves from `Ctrl-T` to `Ctrl-Space`; fzf keeps `Ctrl-T`; editors use Space leaders.
- The current LazyVim and Zed settings must be backed up before selective Stow adoption. Zed prompt databases remain untouched real files.

## Approach and verified references

- Node's official release table identifies Node 24 as LTS and Node 25 as EOL.
- Go supports the two newest release families; Go 1.27.1 is current and Go toolchain auto-selection can satisfy module declarations.
- mise documentation supports built-in Node and Go management and warns that mixed direnv/mise environment ownership is unsupported.
- Existing live editor configs are small and can be selectively adopted without capturing Zed runtime databases.
- Existing Git aliases use unavailable/obsolete `peco` and `hub`; Delta, lazygit, gh, signing, and nvimdiff remain useful.

## Work packages

### safeguards/capture
<!-- workplan-phase-id: safeguards -->
<!-- workplan-step-id: capture -->
- Objective: Create a verifiable rollback point before editing or removing live configuration.
- Owned files / blocked files: external backup directory only; all repo and live config files blocked from modification during capture.
- Dependencies and integration order: first.
- Acceptance criteria: full copies of protected working files and live editor config exist; checksums and baseline status are recorded.
- Validation: restore copies into staging and compare checksums.
- Escalation trigger: unreadable files, symlink ambiguity, or source changes during capture.

### runtime/configure
<!-- workplan-phase-id: runtime -->
<!-- workplan-step-id: configure -->
- Objective: Define runtime ownership and reusable project commands.
- Owned files / blocked files: `mise/.config/mise/**`; application repositories blocked.
- Dependencies: safeguards.
- Acceptance criteria: mise pins Node 24 LTS, pnpm, Bun, Go 1.27.1 and uv; bootstrap/doctor/check/project tasks are discoverable.
- Validation: `mise install`, `mise tasks`, task syntax and fresh-shell origin checks.
- Escalation trigger: a required project version cannot be installed or conflicts with an active project constraint.

### runtime/cutover
<!-- workplan-step-id: cutover -->
- Objective: Make mise the active owner without changing application repositories.
- Owned state: mise/Homebrew runtime installations; repository files blocked except runtime config.
- Dependencies: runtime/configure.
- Acceptance criteria: fresh shells resolve Node, pnpm, Bun, and Go through mise; representative metadata probes succeed; superseded installations no longer shadow mise.
- Validation: executable origins, versions, `npm`/`pnpm`/`bun` metadata-only checks, `go env`, before/after project Git status comparison.
- Escalation trigger: Homebrew reports dependents, project files change, or a required command disappears.

### runtime/direnv
<!-- workplan-step-id: direnv -->
- Objective: Remove unsupported, unused environment-hook overlap.
- Owned files/state: direnv block in `zsh/.zshrc`, Homebrew direnv formula.
- Dependencies: runtime cutover.
- Acceptance criteria: no user `.envrc`, no direnv hook, mise remains activated.
- Validation: scoped file scan, `zsh -n`, fresh interactive shell, command origin check.
- Escalation trigger: a user-owned `.envrc` is found.

### runtime/legacy-python
<!-- workplan-step-id: legacy-python -->
- Objective: Safely clear legacy virtual environments and unnecessary Python.org state.
- Owned state: identified virtualenv directories and external archive directory; no application source files.
- Dependencies: safeguards.
- Acceptance criteria: each legacy environment is archived with checksum and metadata; requirements-backed environments are rebuilt with uv where practical; unknown/unreproducible environments remain restorable; no removed interpreter is referenced.
- Validation: archive extraction test, interpreter/import checks, repeated `pyvenv.cfg` scan.
- Escalation trigger: an environment contains unrecordable local packages or a project has active uncommitted files that cleanup could affect.

### editors/neovim
<!-- workplan-phase-id: editors -->
<!-- workplan-step-id: neovim -->
- Objective: Preserve and manage the current LazyVim setup with Dusk variants.
- Owned files: `nvim/.config/nvim/**`; live matching files during selective adoption.
- Dependencies: safeguards.
- Acceptance criteria: current durable configuration is retained, Dusk Darker is default, and Space leader behavior is explicit.
- Validation: Stow simulation, headless startup, managed-target symlink checks.
- Escalation trigger: live content changes after backup or headless startup mutates tracked files.

### editors/zed
<!-- workplan-step-id: zed -->
- Objective: Manage durable Zed settings, keymap, and Dusk themes without capturing runtime state.
- Owned files: `zed/.config/zed/settings.json`, `keymap.json`, `themes/**`; corresponding live files only.
- Blocked: `~/.config/zed/prompts/**` and other databases.
- Dependencies: safeguards.
- Acceptance criteria: durable preferences are retained, Vim mode and Space leader are enabled, ephemeral temp permissions are removed, Dusk Darker is default, and prompt DB checksums are unchanged.
- Validation: JSONC parse, Stow simulation/adoption, symlink and checksum checks.
- Escalation trigger: Zed rejects a schema field or runtime files collide with Stow.

### workflow/git-keys
<!-- workplan-phase-id: workflow -->
<!-- workplan-step-id: git-keys -->
- Objective: Replace obsolete Git aliases and resolve global/pane/editor key ownership.
- Owned files: `git/.gitconfig`, `tmux/.config/tmux/tmux.conf`, `tmux/.config/tmux/utility.conf`; AeroSpace validation-only.
- Dependencies: editor keymap decisions.
- Acceptance criteria: `gh` replaces `hub`, unsafe `peco` pipelines are removed, main is default, safe worktree helpers exist, tmux uses Ctrl-Space, and fzf Ctrl-T is reachable.
- Validation: Git config parse, isolated temporary worktree lifecycle, isolated tmux server inspection.
- Escalation trigger: a replacement changes destructive semantics or collides with macOS/AeroSpace bindings.

### reproducibility/brew-bootstrap
<!-- workplan-phase-id: reproducibility -->
<!-- workplan-step-id: brew-bootstrap -->
- Objective: Make a fresh setup reproducible without cleanup side effects.
- Owned files: `Brewfile`, mise bootstrap/check task files.
- Dependencies: final runtime/editor/tool decisions.
- Acceptance criteria: direct prerequisites and apps are declared; mise-owned runtimes, direnv, Apple container, and dependency leaves are excluded; bootstrap never cleans or removes packages.
- Validation: `brew bundle check`, Stow simulation, bootstrap check/dry-run twice.
- Escalation trigger: required tapped packages need broad trust or a package cannot be represented safely.

### reproducibility/docs
<!-- workplan-step-id: docs -->
- Objective: Document the delivered environment and recovery process.
- Owned files: `README.md` only, last writer.
- Dependencies: all implementation steps.
- Acceptance criteria: setup, ownership, tasks, themes, keys, worktrees, migration and rollback are accurate; duplicate malformed prose is repaired.
- Validation: command/file cross-check and markdown inspection.
- Escalation trigger: documentation requires behavior not actually validated.

### reproducibility/final-validation
<!-- workplan-step-id: final-validation -->
- Objective: Accept the integrated migration on current evidence.
- Owned state: read-only checks except expected caches.
- Dependencies: all steps.
- Acceptance criteria: focused checks pass and independent review has no unresolved blocker/critical/major findings.
- Validation: `git diff --check`, Zsh, mise, editor, Git/worktree, tmux, Stow and Brew checks plus fresh code-checker review.
- Escalation trigger: two substantive fix attempts fail or evidence contradicts the chosen architecture.

## Validation and review strategy

Use the narrowest checks for each changed behavior. Preserve project Git status while probing runtimes. Run editor checks with temporary state where possible. Test Git worktrees only in the approved temporary directory. Review the final integrated diff in a fresh `code-checker` session and return concrete findings to the relevant implementer.

## Risks and open questions

- Virtual environments are not self-contained; interpreter removal is gated on rebuild or archive evidence.
- Homebrew uninstall may autoremove unrelated formulae; capture installed state and reinstall any unexpected removals immediately.
- Stow can accidentally fold application state directories; use selective files and `--no-folding` simulation.
- Zed keymap/theme schema may differ by installed version; validate against current application behavior or parser evidence.
- Global task auto-detection should remain conservative and never rewrite project lockfiles.

## Execution receipts

- Safeguards: protected working files and live editor configs were copied and checksum-verified under the approved OpenCode temporary root before migration.
- Runtimes: mise now owns Node `24.21.0`, pnpm `11.17.0`, Bun `1.4.0`, Go `1.27.1`, and uv `0.12.12`; uv owns Python `3.14.7`. Fresh interactive-shell origins and representative uv/pnpm/Bun/Go projects were validated without changing lock/module metadata.
- Python cleanup: seven legacy environments were archived and restore-checked under `~/Library/Application Support/dotfiles-backups/python-venvs-20260911`; requirements-backed and tool environments were rebuilt, imports passed, all Python.org 3.13 references were cleared, then Python.org 3.13 was removed.
- Editors: current Neovim and durable Zed settings were backed up under `~/Library/Application Support/dotfiles-backups/editor-configs-20260911`, selectively Stowed, and validated with headless Neovim, strict Zed JSON/theme checks, symlink checks, and unchanged Zed prompt state.
- Workflow: Git parsing and a temporary worktree lifecycle passed; isolated tmux validation confirmed the `Ctrl-Space` prefix, literal-prefix pass-through, popup bindings, and free `Ctrl-T`.
- Reproducibility: `brew bundle check`, `brew missing`, two full bootstrap runs, and two read-only bootstrap checks passed. Docker reports the `orbstack` context/server and Neovim reports stable `0.12.5`.
- Review: the first code-checker pass raised a pyenv concern that conflicts with the explicit completed pyenv-to-uv migration decision, plus two documentation issues. The pyenv finding was resolved as not applicable; README TPM wording and these receipts were corrected. Re-review passed with no blocker, critical, or major findings; its remaining minor Reika portability note was resolved by documenting that protected customization as local and unmanaged.
- Additional tester session was permission-blocked before executing shell; the parent ran its requested checks directly.

## Resume point

- Terminal state: completed. No further implementation step is authorized by this workplan.
- Unresolved findings / decision required: none.
