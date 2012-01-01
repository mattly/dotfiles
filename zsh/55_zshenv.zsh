#! /bin/zsh

export PATH=/bin:/sbin:/usr/sbin:/usr/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH
if [ -d "$HOME/bin" ]; then
    export PATH=$HOME/bin:$PATH
fi

export EDITOR="vim"
export CLICOLOR=YES
export LC_CTYPE=en_US.UTF-8
export DISPLAY=":0.0"
export PAGER=vimpager
export LESS='-MRQ-z-4'
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;36'

# set word boundaries to include punctuation
export WORDCHARS=''

if [ -e "$HOME/.env" ]; then
  source ~/.env
fi

