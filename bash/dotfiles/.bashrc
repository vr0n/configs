# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

PATH=$PATH:/usr/sbin:/usr/sbin/genymotion:/home/vr0n/icecat:/home/vr0n/ti/ccs1010/ccs/eclipse:/usr/lib/jvm:~/.local/bin:~/.cargo/bin/rustup

#tmux attach if we are not already in tmux
if [ $TERM != "screen" ]; then
	#exec tmux attach;
    echo ""
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=20000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color|screen) color_prompt=yes;;
    screen) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

# just force color_prompt... ive never had an issue with this in the past.
color_prompt=yes
#if [ -n "$force_color_prompt" ]; then
#    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#	# We have color support; assume it's compliant with Ecma-48
#	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#	# a case would tend to support setf rather than setaf.)
#	color_prompt=yes
#    else
#	color_prompt=
#    fi
#fi

if [ "$color_prompt" = yes ]; then
	if [ "$HOME" != "/root" ]; then
    		PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\][\[\033[01;31m\]\u\[\033[00;32m\]♻\[\033[01;31m\]\h\[\033[00;32m\]]\[\033[00;32m\][\[\033[01;34m\]\w\[\033[00m\]\[\033[00;32m\]]\n\[\033[01;32m\]>>\[\033[00m\] '
	else
    		PS1='${debian_chroot:+($debian_chroot)}\[\033[00;32m\][\[\033[01;31m\]\u\[\033[01;33m\]⚠\[\033[01;31m\]\h\[\033[00;32m\]]\[\033[00;32m\][\[\033[01;34m\]\w\[\033[00m\]\[\033[00;32m\]]\n\[\033[01;32m\]>>\[\033[00m\] '
	fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# TAKE THE BELOW ADVICE... EVENTUALLY
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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#figlet -f $(/usr/bin/ls /usr/share/figlet/ | sort -R | head -n 1) $(whoami) | lolcat

# define functions for stuff
# "fix" cd so it ls-es everytime
#function cd() {
#	if [ ! -z "$1" ]; then
#		builtin cd "$1" && ls -lah --color=auto
#	else
#		builtin cd ~ && ls -lah --color=auto
#	fi
#}

# extraction function i stole from DT
function ex()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# git commit function
function gcom() {
	printf 'Enter commit message:\n'
	read mess

	if [ ! -z $mess ]; then
        	git commit -m "$mess"
	fi
}

# git remote add function
function rset() {
	printf 'Enter remote url/ssh path:\n'
        read remote

	if [ ! -z $remote ]; then
		git remote add origin $remote
	fi
}

# package manager commands
alias grab="sudo apt-get install -y"
alias purge="sudo apt purge -y"
alias remove="sudo apt autoremove -y"
alias update="sudo apt update -y"
alias upgrade="sudo apt upgrade -y"

alias ..="cd .."
alias build="make clean && make && sudo make install"
alias cp="cp -i"
alias df="df -h"
alias irc="ssh irc"
#alias ls="ls -lah --color=auto"
alias mv="mv -i"
alias obs="LIBGL_ALWAYS_SOFTWARE=1 obs &"
alias p="upower --dump | grep 'percentage\|state' | sort | uniq"
alias psa="ps aux"
alias psg="ps aux | grep"
alias rm="printf 'stop using rm... use tp instead...\n'; false"
alias search="sudo apt search"
alias talist="~/.config/talist/src/talist"
alias te="trash-empty"
alias tl="trash-list"
alias tp="trash-put"
alias when="history | grep"

# shortcuts for git
alias add="git add ."
alias clone="git clone" 
alias commit="git commit -m"
alias gall="add && gcom && push"
alias pull="git pull origin"
alias push="git push origin master"
alias set="git remote add origin"
alias ytdl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
#source "$HOME/.cargo/env"
