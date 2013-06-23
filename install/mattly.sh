brew readline
brew bcrypt
brew openssl

# git tools
brew git
brew hub
brew tig

# personal
github mattly/dotfiles ~/code/mattly/dotfiles
# on_install_or_update "cd $lastdir && make symlink"

# environment
brew fish
# on_install "set_shell fish"
brew tmux
brew reattach-to-user-namespace --wrap-pbpaste-and-pbcopy

# vim
# group vim
brew vim
github gmarik/vundle vim/bundle/vundle
#sh vim +BundleInstall +qall
# endgroup vim

# PL
brew rbenv
brew ruby-build

rbenv 1.9.3-p429
export CONFIGURE_OPTS=--with-openssl-dir=`command brew --prefix openssl`
rbenv 2.0.0-p195

github OiNutter/nodenv $HOME/.nodenv
github OiNutter/node-build $HOME/.nodenv/plugins/node-build

nodenv 0.6.17
nodenv 0.8.14
nodenv 0.10.11

brew clojure
brew erlang
brew elixir

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
