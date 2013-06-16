# -- PATH
if status --is-login
  function unshift_path
    if test -d $arg
      set -xg PATH $arg $PATH
    end
  end

  unshift_path /bin /sbin
  unshift_path /usr/bin /usr/sbin
  unshift_path /usr/local/bin /usr/local/sbin

  unshift_path $HOME/bin
  unshift_path $HOME/.rbenv/bin
  unshift_path $HOME/.nodenv/bin

  if test -d $HOME/.rbenv
    set -x PATH $HOME/.rbenv/bin $PATH
    set -x PATH $HOME/.rbenv/shims $PATH
    rbenv rehash >/dev/null ^&1
  end
end

# -- ENV
set -xg EDITOR "vim"
set -xg BROWSER "open"

# -- HOST SPECIFIC
if test -e "$HOME/.env"
  . ~/.env
end

# -- PROMPT AWESOME
function fish_prompt -d "Write out the prompt"
  set -l exit_status $status

  printf "\n"
  printf '%s@%s' (whoami) (hostname|cut -d . -f 1)
  printf ':%s' (prompt_pwd)

  set -l git_status (git status 2> /dev/null)
  if test $git_status[1]
    printf ' %s±%s' (set_color blue) (set_color normal)
    if echo $git_status[1] | grep "Not currently on any branch." >/dev/null
      printf 'no-branch'
    else
      printf '%s' (echo $git_status[1] | awk ' { print $4 } ')
    end
    if echo $git_status[2] | grep "Your branch is" >/dev/null
      switch (echo $git_status[2] | awk ' { print $5 } ')
        case 'ahead'
          printf "%s↑%s" (set_color cyan) (set_color normal)
        case 'diverged'
          printf "%s↕%s" (set_color magenta) (set_color normal)
        case 'behind'
          printf "%s↓%s" (set_color green) (set_color normal)
        case '*'
          printf '::%s' (echo $git_status[2] | awk ' { print $5 } ' )
      end
    end
    if echo $git_status | grep "nothing to commit" >/dev/null
    else
      printf '%s✦%s' (set_color red) (set_color normal)
    end
  end

  if test $exit_status -eq 0
    printf ' %s:)' (set_color green)
  else
    printf ' %s:(E%s' (set_color red) $exit_status
  end

  printf '%s ' (set_color normal)
end

# -- DISH THE FISH
set fish_greeting ""
set -x CLICOLOR 1

