# Fish pilot configuration. Zsh remains the login shell and rollback path.

# ── Path ─────────────────────────────────────────────────
# Keep these session-local rather than writing universal Fish variables.
fish_add_path --global --move \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    /usr/local/bin \
    "$HOME/.local/bin" \
    "$HOME/.cargo/bin" \
    "$HOME/.opencode/bin" \
    "$HOME/.lmstudio/bin" \
    "$HOME/.pub-cache/bin" \
    "$HOME/go/bin"

# Added by OrbStack: command-line tools and integration.
# Mirrors ~/.zprofile's `source ~/.orbstack/shell/init.zsh`.
if test -f "$HOME/.orbstack/shell/init2.fish"
    source "$HOME/.orbstack/shell/init2.fish"
end


# ── Environment ──────────────────────────────────────────
set -gx EDITOR nvim
set -gx EZA_CONFIG_DIR "$HOME/.config/eza/themes/dusk-darker"
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANROFFOPT -c
set -gx _ZO_DOCTOR 0

if not status is-interactive
    return
end

set -g fish_greeting


# ── Dusk Darker interactive colours ─────────────────────
set -g fish_color_normal FFFFFF
set -g fish_color_command 8BD3FF
set -g fish_color_function 8BD3FF
set -g fish_color_builtin 78E1D0
set -g fish_color_keyword C4A2D4
set -g fish_color_quote 9BE6B5
set -g fish_color_redirection DDA05C
set -g fish_color_end C4A2D4
set -g fish_color_error FF8F9A
set -g fish_color_param E6E9F2
set -g fish_color_option B0BCE8
set -g fish_color_comment 697080
set -g fish_color_selection --background=414B5E
set -g fish_color_search_match --background=333B4B
set -g fish_color_operator F4DA86
set -g fish_color_escape 78E1D0
set -g fish_color_autosuggestion 697080
set -g fish_color_cancel FF8F9A
set -g fish_color_cwd 8BD3FF
set -g fish_color_cwd_root FF8F9A
set -g fish_color_history_current --bold
set -g fish_color_valid_path --underline

set -g fish_pager_color_progress C4A2D4
set -g fish_pager_color_prefix 8BD3FF --bold
set -g fish_pager_color_completion FFFFFF
set -g fish_pager_color_description 858B9C
set -g fish_pager_color_selected_background --background=414B5E


# ── Aliases & abbreviations ──────────────────────────────
alias vim nvim
alias cat 'bat --paging=never'

if type -q eza
    alias ls 'eza --icons --group-directories-first'
    alias ll 'eza -la --icons --group-directories-first'
    alias l 'eza -l --icons --group-directories-first'
else
    alias ls 'ls -G'
    alias ll 'ls -laG'
    alias l 'ls -lG'
end

abbr -a b btop
abbr -a d lazydocker
abbr -a ff fastfetch
abbr -a hoshi hoshino
abbr -a ocode opencode2
abbr -a grep rg

# Interactive counterpart to Zsh's global --help alias.
if type -q bat
    abbr --add --position anywhere -- --help '--help 2>&1 | bat --language=help --style=plain'
end


# ── fzf ──────────────────────────────────────────────────
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_DEFAULT_OPTS '--color=bg+:#333B4B,spinner:#FFD4E2,hl:#FF8F9A --color=fg:#FFFFFF,header:#FF8F9A,info:#C4A2D4,pointer:#FFD4E2 --color=marker:#B0BCE8,fg+:#FFFFFF,prompt:#C4A2D4,hl+:#FF8F9A --color=selected-bg:#414B5E --border=rounded --height=50%'
if type -q bat
    set -gx FZF_CTRL_T_OPTS "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
end

if type -q eza
    set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --icons --color=always {} | head -50'"
else
    set -gx FZF_ALT_C_OPTS "--preview 'command ls -la {} | head -50'"
end

if type -q fzf
    fzf --fish | source
end


# ── History Navigation ───────────────────────────────────
bind up up-or-search
bind down down-or-search


# ── Yazi ─────────────────────────────────────────────────
function y --description 'Open Yazi and change to its exit directory'
    set -l tmp (mktemp -t yazi-cwd.XXXXXX); or return

    yazi $argv --cwd-file="$tmp"

    if set -l cwd (command cat -- "$tmp")
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            builtin cd -- "$cwd"
        end
    end

    command rm -f -- "$tmp"
end


# ── OpenCode / Reika ─────────────────────────────────────
# Load simple KEY=value records only for the launched process.
function __with_opencode_env --argument-names executable
    set -e argv[1]
    set -l env_file "$HOME/.config/opencode/.env"

    if test -f "$env_file"
        while read -l line
            string match -qr '^\s*(#|$)' -- "$line"; and continue

            set -l pair (string split -m 1 = -- "$line")
            if test (count $pair) -ne 2
                echo "Invalid environment entry: $env_file" >&2
                return 1
            end

            set -l key (string trim -- "$pair[1]")
            if not string match -qr '^[A-Za-z_][A-Za-z0-9_]*$' -- "$key"
                echo "Invalid environment key: $env_file" >&2
                return 1
            end

            set --function --export "$key" "$pair[2]"
        end < "$env_file"
    end

    command "$executable" $argv
end

function opencode
    __with_opencode_env opencode $argv
end

function reika
    __with_opencode_env /Users/cantabile/projects/personal/reika/packages/cli/dist/cli-darwin-arm64/bin/reika $argv
end


# ── Tool Initialization ──────────────────────────────────
if type -q zoxide
    zoxide init fish --cmd cd | source
end

if type -q mise
    mise activate fish | source
end

function starship_transient_prompt_func
    starship module character
end

if type -q starship
    starship init fish | source
    enable_transience
end
