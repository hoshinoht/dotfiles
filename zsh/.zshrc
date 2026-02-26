# ── Path ─────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="/Users/cantabile/.antigravity/antigravity/bin:$PATH"
export IDF_PATH=~/esp/esp-idf
export PATH="$IDF_PATH/tools:$PATH"

# ── oh-my-zsh ────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""  # Using Starship

# Skip compaudit permission checks (saves ~15ms)
ZSH_DISABLE_COMPFIX=true

# Skip oh-my-zsh auto-update check at startup (saves ~6ms)
zstyle ':omz:update' mode disabled  # Run `omz update` manually instead

plugins=(
  git
  docker docker-compose
  kubectl
  python pip node npm
  sudo extract history
  zsh-autosuggestions
  fzf-tab
  fast-syntax-highlighting  # Must be last
)

source $ZSH/oh-my-zsh.sh

# ── Options ──────────────────────────────────────────────
unsetopt prompt_sp

# ── Environment ──────────────────────────────────────────
export EDITOR=nvim
export EZA_CONFIG_DIR="$HOME/.config/eza"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"
PICO_SDK_PATH=~/Projects/sit/inf2004/pico-sdk
PICO_BOARD=pico_w

# ── Aliases ──────────────────────────────────────────────
alias vim='nvim'
alias python='python3'
alias pip='pip3'
alias cat='bat --paging=never'
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias l='eza -l --icons --group-directories-first'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias b='btop'
alias d='lazydocker'

# ── fzf ──────────────────────────────────────────────────
# Cache fzf init to avoid fork on every shell launch
if [[ ! -f ~/.fzf-zsh.cache || ~/.fzf-zsh.cache -ot $(command -v fzf) ]]; then
  fzf --zsh > ~/.fzf-zsh.cache
fi
source ~/.fzf-zsh.cache
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=" \
  --color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
  --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
  --color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
  --color=selected-bg:#494d64 \
  --border=rounded --height=50%"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --color=always {} | head -50'"

# fzf-tab: rich previews
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --icons --color=always $realpath | head -50'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza --tree --icons --color=always $realpath | head -50'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps -p $word -o pid,user,%cpu,%mem,command'
zstyle ':fzf-tab:complete:git-(checkout|diff|log):*' fzf-preview \
  'git log --oneline --graph --color=always $word -- 2>/dev/null | head -30'
zstyle ':fzf-tab:complete:brew-(install|info|uninstall):*' fzf-preview \
  'brew info $word 2>/dev/null | head -20'
zstyle ':fzf-tab:*' continuous-trigger tab
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'

# ── Transient prompt ─────────────────────────────────────
# Collapses previous prompts to minimal ">" after command runs
zle-line-init() {
  [[ $CONTEXT == start ]] || return 0
  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done
  local saved_prompt=$PROMPT saved_rprompt=$RPROMPT
  PROMPT='%(?.%F{#a6da95}.%F{#ed8796})❯%f '
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt
  if (( ret )); then zle .send-break; else zle .accept-line; fi
  return ret
}
zle -N zle-line-init

# ── Window title ─────────────────────────────────────────
function set_win_title() { echo -ne "\033]0;${PWD/#$HOME/~}\007" }
function preexec_win_title() { echo -ne "\033]0;${1}\007" }
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_win_title
add-zsh-hook preexec preexec_win_title


# ── yazi (cd on exit) ────────────────────────────────────
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# ── Tool inits (keep at bottom) ──────────────────────────
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cd)"
alias z='__zoxide_z'
alias zi='__zoxide_zi'
# zoxide MUST be the very last init — suppress its false-positive doctor warning
export _ZO_DOCTOR=0
# fastfetch
