#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export TERM="alacritty"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export MANPAGER="nvim +Man!"
export CHROME_BIN="chromium"

export PATH="${PATH}:${HOME}/.dotnet/tools"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth

shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=10000
export HISTFILESIZE=50000

# load aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#PS1='[\u@\h \W]\$ '
export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash


# Load Angular CLI autocompletion.
source <(ng completion script)

# Zoxide
eval "$(zoxide init bash)"
