# Load Fast Syntax Highlighting after every other ZLE integration.
#
# FSH caches the previous buffer. During bracketed paste, ZLE shifts the old
# highlight regions before FSH's wrapper runs, but the cached buffer already
# matches the pasted text. FSH then skips its full pass and leaves zero-width
# regions at the end of the buffer. Clear that cache after the underlying paste
# widget so FSH rebuilds the regions once the paste is complete.

typeset -g _dotfiles_fsh_plugin="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

if [[ ! -r "$_dotfiles_fsh_plugin" ]]; then
  print -u2 "Fast Syntax Highlighting not found: $_dotfiles_fsh_plugin"
  unset _dotfiles_fsh_plugin
  return 1
fi

if (( $+widgets[bracketed-paste] )); then
  zle -A bracketed-paste _dotfiles_fsh_original_bracketed_paste

  function _dotfiles_fsh_bracketed_paste() {
    zle _dotfiles_fsh_original_bracketed_paste -- "$@"
    local -i ret=$?

    typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER=

    return $ret
  }

  zle -N bracketed-paste _dotfiles_fsh_bracketed_paste
fi

source "$_dotfiles_fsh_plugin"
unset _dotfiles_fsh_plugin

if [[ ${FAST_THEME_NAME:-default} != dusk-darker ]]; then
  fast-theme -q dusk-darker
fi
