function __hoshino_on_repo_change --on-event fish_prompt
    status is-interactive; or return
    command -q hoshino; or return

    # Detect git repository root fast and safely
    set -l repo_root (command git --no-optional-locks rev-parse --show-toplevel 2>/dev/null)

    if test -z "$repo_root"
        set -g __hoshino_last_repo ""
        return
    end

    # Only trigger when switching into a new/different repo root
    if test "$repo_root" != "$__hoshino_last_repo"
        set -g __hoshino_last_repo "$repo_root"
        clear
        command hoshino
    end
end
