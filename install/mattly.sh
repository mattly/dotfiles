# basics
  brew readline
  brew bcrypt
  brew openssl

# git tools
  brew git
  brew hub
  brew tig

# environment
  brew fish
  # on_install "set_shell fish"
  brew tmux
  brew reattach-to-user-namespace --wrap-pbpaste-and-pbcopy

# personal
  code=$HOME/code/mattly
  github mattly/dotfiles $code/dotfiles
  # on_install_or_update "cd $lastdir && make symlink"

# vim
  # group vim
  vim=$code/dotfiles/vim/bundle
  include vim.sh
  # endgroup vim

# PL
  include ruby.sh
  include node.sh

  brew clojure
  brew_tap homebrew/versions
  brew erlang-r16
  brew elixir
  brew bats

# databases
  brew postgresql
  brew redis
  brew riak

# etc tools
  brew ack
  brew curl
  brew jq
  brew nmap
  brew dnsmasq

# prefs
  osx dialogs.expandAll
  osx ui.fast
  osx showAllFiles
  osx finder.disableNetworkDS
  osx dock.autohide
  osx dock.static
  osx timeMachine.off
