#! /bin/zsh

export PATH=/bin:/sbin:/usr/sbin:/usr/bin:$PATH
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH

export TERM=linux
export EDITOR="mvim -f" 
export CLICOLOR=YES
export LC_CTYPE=en_US.UTF-8
export DISPLAY=":0.0"
export PAGER=less
export LESS='-FMRQr-z-4'
export GREP_OPTIONS='--color=auto' 
export GREP_COLOR='1;36'

# set word boundries to include puncutation
export WORDCHARS=''

# export MAGICK_HOME='/usr/local'
# export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib"

source ~/.env
