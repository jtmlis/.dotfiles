#!/bin/zsh

# Add 'pyenv' to PATH.
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Enable shims and autocompletion for pyenv.
eval "$(pyenv init --path)"
# Load pyenv-virtualenv automatically by adding
# # the following to ~/.zshrc:
#
eval "$(pyenv virtualenv-init -)"

# Sets term colors, and fixes problems with SSH for pywal/wpg
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote/ssh
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote/ssh;;
  esac
    # Only change term colors for local system
    if [ -f ${XDG_CONFIG_HOME}/wpg/sequences ]; then
      command cat ${XDG_CONFIG_HOME}/wpg/sequences
    fi
    if [ -f ~/.cache/wal/sequences ]; then
      command cat ${HOME}/.cache/wal/sequences
    fi
fi

if command -v thefuck > /dev/null 2>&1; then
  eval $(thefuck --alias)
fi

source ~/antigen.zsh

antigen bundle git
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle sprunge
antigen bundle vi-mode
antigen bundle key-bindings
antigen bundle colored-man-pages
antigen bundle tmuxinator
antigen bundle wting/autojump
antigen bundle docker
antigen bundle docker-compose
antigen bundle fzf
antigen bundle mosh
antigen bundle nmap
antigen bundle perms
antigen bundle "MichaelAquilina/zsh-you-should-use"
antigen bundle zsh-you-should-use
antigen bundle dotenv
antigen bundle sunlei/zsh-ssh

antigen apply

# The Fuck
if command -v thefuck > /dev/null 2>&1; then
  eval $(thefuck --alias)
fi

# Configure vi mode for plugin
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
VI_MODE_SET_CURSOR=true

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
PATH="$HOME/.local/bin:$PATH"

if [[ $OSTYPE == 'darwin'* ]]; then
  [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
else
  source /usr/share/autojump/autojump.zsh
fi

# Let jobs continue even if shell exits
setopt NO_HUP

# Add 'pyenv' to PATH.
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
#HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

source ~/.keybinds
source ~/.zsh_aliases

if command -v starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo 'Install Starship Prompt https://starship.rs/'
fi


if command -v neofetch > /dev/null 2>&1; then
  neofetch
else
  echo 'Install Neofetch'
fi

# Add local tools to PATH
test -e "${HOME}/.scripts" && PATH="${HOME}/.scripts:${PATH}"
test -e "${HOME}/bin" && PATH="${HOME}/.bin:${PATH}"
test -e "${HOME}/.local/bin" && PATH="${HOME}/.local/bin:${PATH}"
test -e "${HOME}/.emacs.d/bin" && PATH="${HOME}/.emacs.d/bin:${PATH}"

if [ "${IS_MAC}" = "1" ]; then
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  test -e "${HOME}/Library/Python/3.9/bin" && PATH="${HOME}/Library/Python/3.9/bin:${PATH}"
  test -e "/opt/homebrew/opt/ruby/bin" && PATH="/opt/homebrew/opt/ruby/bin:${PATH}"
  test -e "${HOME}/.local/share/gem/ruby/3.0.0/bn" && PATH="${HOME}/.local/share/gem/ruby/3.0.0/bin:${PATH}"
fi

