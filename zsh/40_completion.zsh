#! /bin/zsh
version=`zsh --version | sed 's/zsh \([0-9\.]*\).*/\1/'`

zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
zstyle ':completion:*' menu select=1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ${(s.:.)ZLS_COLORS}
zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=** r:|=**'
zstyle ':completion:*' menu select
# zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
    
# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions
 
# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

#[ Formats ]####################################################################
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group 1
zstyle ':completion:*' format '%B---- %d%b'
zstyle ':completion:*:corrections' format '%B---- %d (errors %e)%b'
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
zstyle ':completion:*' group-name ''

zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'


#[ Kill ]#######################################################################
zstyle ':completion:*:processes' command 'ps -au$USER -o pid,time,cmd|grep -v "ps -au$USER -o pid,time,cmd"'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;30=01;31=01;38'

#[ hosts and users ]############################################################
# source /usr/share/zsh/4.3.9/functions/_ssh
autoload _ssh

zstyle ':completion:*:hosts' list-colors '=(#b)(*)=01;30=01;31' '=[^.]#=01;31'

users=(root matt mattly)
zstyle ':completion:*' users $users

zstyle ':completion:*' file-patterns \
    '%p:globbed-files: *(-/):directories:Directories' '*:all-files'

#[ etc ]########################################################################
# source /usr/share/zsh/4.3.9/functions/_git
autoload _git
zstyle ':completion::*:git-{name-rev,add,rm}:*' ignore-line true
