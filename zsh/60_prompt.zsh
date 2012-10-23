#! /bin/zsh
autoload -U colors && colors
reset_color=${reset_color}

update_git_vars() {
  unset current_git_branch
  unset current_git_branch_status
  unset current_git_branch_is_dirty
  unset current_git_stash_count
  local st="$(git status 2> /dev/null)"
  
  if [ -n "$st" ]; then
    local -a arr
    local stash
    arr=(${(f)st})
  	if echo $arr[1] | grep "Not currently on any branch." >/dev/null; then
  		current_git_branch='no-branch'
  	else
  		current_git_branch="$(echo $arr[1] | awk ' { print $4 } ')"
  	fi
  	if echo $arr[2] | grep "Your branch is" >/dev/null; then
  		if echo $arr[2] | grep "ahead" >/dev/null; then
  			current_git_branch_status='ahead'
  		elif echo $arr[2] | grep "diverged" >/dev/null; then
  			current_git_branch_status='diverged'
  		else
  			current_git_branch_status='behind'
  		fi
  	fi
  	stash=$(git stash list | wc -l | sed 's/^[ \t]*//')
    current_git_stash_count="$stash"
  	if echo $st | grep "nothing to commit (working directory clean)" >/dev/null; then
  	else
  		current_git_branch_is_dirty='1'
  	fi
  fi
}

git_prompt() {
  update_git_vars
  if [ -n "$current_git_branch" ]; then
  	local s="("
  	s+="%B$current_git_branch%b"
  	case "$current_git_branch_status" in
  		ahead)
  		s+="%{$fg[cyan]%}↑%{$reset_color%}"
  		;;
  		diverged)
  		s+="%{$fg[magenta]%}↕%{$reset_color%}"
  		;;
  		behind)
  		s+="%{$fg[green]%}↓%{$reset_color%}"
  		;;
  	esac
  	if [ -n "$current_git_branch_is_dirty" ]; then
  		s+="%{$fg[red]%}✦%{$reset_color%}"
  	fi
  	if [ "$current_git_stash_count" -eq "0" ]; then
	  else
  	  s+="$current_git_stash_count"
	  fi
  	s+=")"

  	printf " %s" $s
  fi
}

setopt prompt_subst
PROMPT=$'
%n@%m:%3~$(git_prompt) %(?.%{$fg[green]%}\:\).%{$fg[red]%}\:\(%?)%{$reset_color%} > '


