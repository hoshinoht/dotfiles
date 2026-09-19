function __hoshino_on_repo_change --on-event fish_prompt
    status is-interactive; or return
    command -q hoshino; or return

    # Detect git repository root fast and safely
    set -l repo_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)

    # 1. On initial shell startup: always run hoshino once (even on non-repos)
    if not set -q __hoshino_initialized
        set -g __hoshino_initialized 1
        set -g __hoshino_last_repo "$repo_root"
        command hoshino
        return
    end

    # 2. Subsequent navigation: skip non-repo directories
    if test -z "$repo_root"
        set -g __hoshino_last_repo ""
        return
    end

    # 3. Only trigger when switching into a new/different repo root
    if test "$repo_root" != "$__hoshino_last_repo"
        set -g __hoshino_last_repo "$repo_root"
        clear
        command hoshino
    end
end
