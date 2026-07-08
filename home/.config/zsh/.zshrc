# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Aliases
. ~/.config/shell/alias

# Plugin options
zstyle ':zephyr:plugin:editor' key-bindings vi
export KEYTIMEOUT=1 # Make mode switch fast

# Load plugins
source $HOME/.local/antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt

# Keybinds
bindkey "^y" autosuggest-accept

# Starship
eval "$(starship init zsh)"
