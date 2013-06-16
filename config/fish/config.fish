# -- PATH
if status --is-login
  function unshift_path
    echo $argv
    for val in $argv
      if test -d $val
        set -xg PATH $val $PATH
      end
    end
  end

  unshift_path /bin /sbin
  unshift_path /usr/bin /usr/sbin
  unshift_path /usr/local/bin /usr/local/sbin

  unshift_path $HOME/bin

  if test -d $HOME/.rbenv
    unshift_path $HOME/.rbenv/shims
    rbenv rehash >/dev/null ^&1
  end

  if test -d $HOME/.nodenv
    unshift_path $HOME/.nodenv/bin
    unshift_path $HOME/.nodenv/shims
    nodenv rehash 2>/dev/null
  end
end

# -- ENV
set -xg EDITOR "vim"
set -xg BROWSER "open"

# -- HOST SPECIFIC
if test -e "$HOME/.env"
  . ~/.env
end

# -- DISH THE FISH
set fish_greeting ""
set -x CLICOLOR 1

