ok brew bat
ok brew curl
ok brew direnv
ok brew editorconfig
ok brew exa
ok brew jq
ok brew mtr
ok brew ripgrep
ok brew the_silver_searcher
ok brew thefuck
ok brew tig

ok brew-tap railwaycat/emacsmacport
ok brew emacs-mac
ok github ~/.emacs.d hlissner/doom-emacs
did_install && cd ~/.emacs.d && make

ok defaults org.gnu.Emacs NSAppSleepDisabled bool YES

ok cask iterm2
ok cask paw

# javascript first because so many damn things depend on node
ok brew node
ok npm npm
ok brew nvm
ok npm js-beautify
ok npm stylelint

register types/npm-config.sh
ok npm-config ignore-scripts true

# clojure
ok brew clojure
ok brew leiningen
ok brew boot
ok brew joker

# rust
ok brew rust
ok brew rustup-init

## databases
ok brew postgresql
ok brew pgcli
ok brew pgweb
# ok brew mysql # if I ever have to use mysql again I'll finally use Docker
