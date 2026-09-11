# ── Path ─────────────────────────────────────────────────
# Zsh's $path array is tied directly to $PATH.
# -U automatically removes duplicate entries.
typeset -U path PATH

typeset -a local_paths

for local_path in \
  "$HOME/.local/bin" \
  "$HOME/.cargo/bin" \
  "$HOME/.opencode/bin" \
  "$HOME/.lmstudio/bin" \
  "$HOME/.pub-cache/bin" \
  "$HOME/go/bin"; do
  path=("${(@)path:#${local_path}}")
  [[ -d "$local_path" ]] && local_paths+=("$local_path")
done

path=($local_paths $path)

unset local_path local_paths

export PATH


# ── SDKs ─────────────────────────────────────────────────
if [[ -n ${IDF_PATH:-} && ! -d "$IDF_PATH" ]]; then
  unset IDF_PATH
fi

function get_idf() {
  local idf_path="${IDF_PATH:-$HOME/esp/esp-idf-v5.5.3}"

  if [[ ! -f "$idf_path/export.sh" ]]; then
    print -u2 "ESP-IDF not found: $idf_path"
    return 1
  fi

  source "$idf_path/export.sh"
}

if [[ -n ${PICO_SDK_PATH:-} && ! -d "$PICO_SDK_PATH" ]]; then
  unset PICO_SDK_PATH PICO_BOARD
fi

if [[ -z ${PICO_SDK_PATH:-} && -d "$HOME/Projects/sit/inf2004/pico-sdk" ]]; then
  export PICO_SDK_PATH="$HOME/Projects/sit/inf2004/pico-sdk"
  export PICO_BOARD="pico_w"
fi


# ── oh-my-zsh ────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Prompt is handled by Starship.
ZSH_THEME=""

# Skip compaudit permission checks.
ZSH_DISABLE_COMPFIX=true

# Disable automatic OMZ update checks.
# Run `omz update` manually.
zstyle ':omz:update' mode disabled

# Autosuggestion ghost text.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#697080'

plugins=(
  git
  docker
  docker-compose
  kubectl
  python
  pip
  bun
  sudo
  extract
  history

  # ZLE-sensitive plugins — ordering matters.
  fzf-tab
  zsh-autosuggestions
)

source "$ZSH/oh-my-zsh.sh"


# ── Options ──────────────────────────────────────────────
unsetopt prompt_sp


# ── Environment ──────────────────────────────────────────
export EDITOR="nvim"

export EZA_CONFIG_DIR="$HOME/.config/eza/themes/dusk-darker"

export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"


# ── Aliases ──────────────────────────────────────────────
alias vim='nvim'
alias cat='bat --paging=never'

if (( $+commands[eza] )); then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --group-directories-first'
  alias l='eza -l --icons --group-directories-first'
else
  alias ls='ls -G'
  alias ll='ls -laG'
  alias l='ls -lG'
fi

alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias b='btop'
alias d='lazydocker'
alias ff='fastfetch'


# ── LS_COLORS (Dusk) ─────────────────────────────────────
[[ -f "$HOME/.dotfiles/zsh/ls_colors.zsh" ]] &&
  source "$HOME/.dotfiles/zsh/ls_colors.zsh"


# ── fzf ──────────────────────────────────────────────────
if (( $+commands[fzf] )); then
  FZF_ZSH_CACHE="$HOME/.cache/fzf-zsh.zsh"

  mkdir -p "${FZF_ZSH_CACHE:h}"

  if [[ ! -f "$FZF_ZSH_CACHE" || "$FZF_ZSH_CACHE" -ot "$commands[fzf]" ]]; then
    fzf --zsh >| "$FZF_ZSH_CACHE"
  fi

  source "$FZF_ZSH_CACHE"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

export FZF_DEFAULT_OPTS=" \
  --color=bg+:#333B4B,spinner:#FFD4E2,hl:#FF8F9A \
  --color=fg:#FFFFFF,header:#FF8F9A,info:#C4A2D4,pointer:#FFD4E2 \
  --color=marker:#B0BCE8,fg+:#FFFFFF,prompt:#C4A2D4,hl+:#FF8F9A \
  --color=selected-bg:#414B5E \
  --border=rounded \
  --height=50%"

export FZF_CTRL_T_OPTS="\
--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

export FZF_ALT_C_OPTS="\
--preview 'eza --tree --icons --color=always {} | head -50'"


# ── fzf-tab ──────────────────────────────────────────────
zstyle ':fzf-tab:complete:cd:*' \
  fzf-preview 'eza --tree --icons --color=always $realpath | head -50'

zstyle ':fzf-tab:complete:ls:*' \
  fzf-preview 'eza --tree --icons --color=always $realpath | head -50'

zstyle ':fzf-tab:complete:kill:argument-rest' \
  fzf-preview 'ps -p $word -o pid,user,%cpu,%mem,command'

zstyle ':fzf-tab:complete:git-(checkout|diff|log):*' \
  fzf-preview 'git log --oneline --graph --color=always $word -- 2>/dev/null | head -30'

zstyle ':fzf-tab:complete:brew-(install|info|uninstall):*' \
  fzf-preview 'brew info $word 2>/dev/null | head -20'

zstyle ':fzf-tab:*' continuous-trigger tab

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'


# ── Transient Prompt ─────────────────────────────────────
# Collapse previous prompts to a minimal ❯ after a
# command is executed.
zle-line-init() {
  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit

    local -i ret=$?

    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT

  PROMPT='%(?.%F{#697080}.%F{#FF8F9A})❯%f '
  RPROMPT=''

  zle .reset-prompt

  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi

  return ret
}

zle -N zle-line-init


# ── History Navigation ───────────────────────────────────
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search


# ── Window Title ─────────────────────────────────────────
function set_win_title() {
  printf '\033]0;%s\007' "${PWD/#$HOME/~}"
}

function preexec_win_title() {
  printf '\033]0;%s\007' "$1"
}

autoload -Uz add-zsh-hook

add-zsh-hook precmd set_win_title
add-zsh-hook preexec preexec_win_title


# ── Yazi ─────────────────────────────────────────────────
# Change the current shell directory when exiting Yazi.
function y() {
  local tmp
  local cwd

  tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" || return

  yazi "$@" --cwd-file="$tmp"

  if cwd="$(command cat -- "$tmp")" &&
     [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    builtin cd -- "$cwd"
  fi

  command rm -f -- "$tmp"
}


# ── Tool Initialization ──────────────────────────────────
# Keep shell-generated initialization near the bottom.

if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh --cmd cd)"

  alias z='__zoxide_z'
  alias zi='__zoxide_zi'

  # Suppress zoxide's false-positive doctor warning.
  export _ZO_DOCTOR=0
fi

if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# ── OpenCode ─────────────────────────────────────────────
# Load OpenCode secrets only for the OpenCode process
# instead of exporting them to every child process.
function opencode() {
  (
    if [[ -f "$HOME/.config/opencode/.env" ]]; then
      set -a
      source "$HOME/.config/opencode/.env"
      set +a
    fi

    command opencode "$@"
  )
}


# ── Reika ────────────────────────────────────────────────
# Keep the caller's current directory as Reika's workspace.
function reika() {
  (
    if [[ -f "$HOME/.config/opencode/.env" ]]; then
      set -a
      source "$HOME/.config/opencode/.env"
      set +a
    fi

    command /Users/cantabile/projects/personal/reika/packages/cli/dist/cli-darwin-arm64/bin/reika "$@"
  )
}


# ── Bun Completions ──────────────────────────────────────
[[ -s "$HOME/.bun/_bun" ]] &&
  source "$HOME/.bun/_bun"


# ── Fast Syntax Highlighting ──────────────────────────────
# Load last so it can wrap every ZLE widget defined above.
source "$HOME/.dotfiles/zsh/fast-syntax-highlighting.zsh"


# ── Fastfetch ────────────────────────────────────────────
# Run manually with `ff`.
#
# Uncomment if you specifically want Fastfetch every time
# an interactive shell opens.
#
# (( $+commands[fastfetch] )) && fastfetch
