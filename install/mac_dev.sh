include osx.sh

ok brew
ok brew git

include dotfiles.sh

# basics
ok brew readline
ok brew bcrypt
ok brew openssl

# git tools
ok brew hub
ok brew tig

# environment
ok brew fish
if did_install; then
  echo "changing shell to fish, you will need to enter your password"
  sudo echo /usr/local/bin/fish >> /etc/shells
  chsh -s /usr/local/bin/fish
fi

include tmux.sh
include vim.sh

# etc tools
ok brew the_silver_searcher
ok brew par
ok brew curl
ok brew jq
ok brew nmap
ok brew dnsmasq
ok brew mtr
ok brew graphviz
ok pip httpie

ok brew direnv

ok brew apple-gcc42

ok brew ansible

include apps.sh
include sketch.sh
