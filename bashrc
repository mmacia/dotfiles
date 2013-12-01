# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export PATH=${PATH}:$HOME/local/bin:$HOME/.rvm/bin:/opt/android/tools:/opt/android/platform-tools
export EDITOR=vim
export SHELL=bash

# loads RVM into shell session
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# loads phpbrew config
[[ -s "$HOME/.phpbrew/bashrc" ]] && . "$HOME/.phpbrew/bashrc"

# set vi mode
set -o vi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# synchronize history in each time you type a command
export PROMPT_COMMAND="history -a; history -n"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Human readable colors aliases for escape codes
source ~/.bash_colors

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    xterm-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

function ruby_version {
  if [[ -f ~/.rvm/bin/rvm-prompt ]]; then
    local system=$(~/.rvm/bin/rvm-prompt s)
    local interp=$(~/.rvm/bin/rvm-prompt i)

    if [[ -n $system ]]; then
      # Don't show interpreter if it's just MRI
      case $interp in
        ruby) echo "$(~/.rvm/bin/rvm-prompt v g)" ;;
        *) echo "$(~/.rvm/bin/rvm-prompt i v g)" ;;
      esac
    fi
  fi
}

if [ "$color_prompt" = yes ]; then
  host_color=$BRIGHT_GREEN

  if [ "$(whoami)" = "root" ]; then
      host_color=$BRIGHT_RED
  fi

  # prompt modules
  host="${BRIGHT_VIOLET}┌ ${RST}\${debian_chroot:+($debian_chroot)}$host_color\u@\h"
  date="${RST}\d "
  ruby="${BRIGHT_VIOLET}♦ \$(ruby_version)${RST}"
  memory="M\$($HOME/.dotfiles/scripts/prompt_memory_status)"
  battery="\$($HOME/.dotfiles/scripts/prompt_battery_status)"
  git="${BRIGHT_YELLOW}\$(__git_ps1)${RST}"
  path="${BRIGHT_BLUE}\w${RST}"
  caret="\$"

  if [ "$(whoami)" = "root" ]; then
    caret="#"
  fi

  PS1="${host} ${ruby} ${date} ${memory} ${battery}\n${BRIGHT_VIOLET}└${RST} ${path}${git}${caret} "

  unset host
  unset date
  unset memory
  unset battery
  unset git
  unset path
  unset caret
  unset host_color
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

