ok brew
ok brew git

# include dotfiles.sh
ok directory $HOME/code/mattly
destination $HOME/code/mattly
ok github mattly/dotfiles

destination $HOME
for config in $HOME/code/mattly/dotfiles/configs/*; do
  ok symlink "$HOME/.$(basename $config)" $config
done
# ---


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

# include tmux.sh
ok brew tmux
ok brew reattach-to-user-namespace --wrap-pbpaste-and-pbcopy

ok directory $HOME/.tmux
destination $HOME/.tmux

ok github bruno-/tmux_goto_session
ok github bruno-/tmux_battery_osx
# ---
# include vim.sh
ok brew vim

# TODO: keep track of 'any' changes

[ -z $code ] && code=$HOME/code/mattly
destination $code/dotfiles/configs/vim/bundle

#group start --dir=$code/dotfiles/vim/bundle

# plugin helpers
  ok github tpope/vim-pathogen
  ok github tpope/vim-repeat

# file helpers
  ok github tpope/vim-eunuch

# insert-mode helpers
  ok github Townk/vim-autoclose
  ok github ervandew/supertab
  ok github tpope/vim-endwise
  ok github tpope/vim-surround

# text manipulation
  ok github tpope/vim-commentary
  ok github junegunn/vim-easy-align
  ok github tpope/vim-abolish
  ok github terryma/vim-multiple-cursors
  ok github tpope/vim-characterize

# text-objects
  ok github michaeljsmith/vim-indent-object
  ok github gcmt/wildfire.vim
  ok github tpope/vim-jdaddy
  ok github wellle/targets.vim

# writing tools
  ok github junegunn/goyo.vim
  ok github junegunn/limelight.vim

  ok github reedes/vim-pencil
  ok github reedes/vim-lexical
  ok github reedes/vim-wordy
  ok github nelstrom/vim-markdown-folding

# outlining
  ok github vim-voom/VOoM

# dash integration
  ok github rizzatti/funcoo.vim
  ok github rizzatti/dash.vim

# navigation
  ok github rking/ag.vim
  ok github tpope/vim-vinegar

# UI and colors
  ok github reedes/vim-colors-pencil
  ok github kien/rainbow_parentheses.vim

# git & scm
  ok github tpope/vim-git                 # .gitcommit
  ok github tpope/vim-fugitive
  ok github mhinz/vim-signify
  ok github idanarye/vim-merginal

# snip!
  ok github tomtom/tlib_vim
  ok github MarcWeber/vim-addon-mw-utils
  ok github garbas/vim-snipmate
  ok github honza/vim-snippets

# Language/Environment-Specific

  # Clojure
    ok github guns/vim-clojure-static       # .clj        clojure syntax
    ok github guns/vim-sexp
    ok github tpope/vim-sexp-mappings-for-regular-people
    ok github tpope/vim-fireplace

  # CSS
    ok github cakebaker/scss-syntax.vim     # .scss       -> .css
    ok github groenewege/vim-less           # .less       -> .css
    ok github wavded/vim-stylus             # .styl       -> .css

  # Javascript
    ok github pangloss/vim-javascript       # .js         better indenting
    ok github kchmck/vim-coffee-script      # .coffee     -> .js
    ok github mintplant/vim-literate-coffeescript
                                        # .litcoffee  -> .js

  # Markup / Templates
    ok github tpope/vim-ragtag              # .html       formatting tools
    ok github juvenn/mustache               # .mustache   :{
    ok github Glench/Vim-Jinja2-Syntax      # .html       jinja/nunjukcs/swig
    ok github digitaltoad/vim-jade          # .jade       -> .html

  # Shell
    ok github rosstimson/bats.vim           # .bats       bash unit testing
    ok github aliva/vim-fish                # .fish

  # Viml
    ok github tpope/vim-scriptease
    ok github dbakker/vim-lint

  # Miscellaneous
    ok github vim-scripts/csv.vim           # .csv
    ok github ekalinin/Dockerfile.vim       # Dockerfile
    ok github elixir-lang/vim-elixir        # .ex
    ok github jimenezrick/vimerl            # .erl
    ok github jnwhiteh/vim-golang           # .go
    ok github wannesm/wmgraphviz.vim        # .gv         graphviz
    ok github travitch/hasksyn              # .hs
    ok github wting/rust.vim                # .rust
    ok github toyamarinyon/vim-swift
    ok github exu/pgsql.vim                 # .sql        postgresql 4 life
    ok github andersoncustodio/vim-tmux     # tmux.config
    ok github sheerun/vim-yardoc            # yard inside .rb

# TODO if "any" changes, vim ':Helptags'

#group end
# ---

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
ok pip virtualenv

ok brew direnv

ok brew apple-gcc42

ok brew ansible

# include osx.sh
# TODO: perhaps pull inspiration from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# auto-expand save, print dialogs
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint2 bool true

# default to save to disk, not iCloud
ok defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false

# disable gatekeeper
ok defaults com.apple.LaunchServices LSQuarantine bool false

# speed up the UI
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001
# fix the UI
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
# show all extensions
ok defaults NSGlobalDomain AppleShowAllExtensions bool true
# help viewer to regular window
ok defaults com.apple.helpviewer DevMode bool true

# disable auto spelling correction
ok defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

ok defaults com.apple.desktopservices DSDontWriteNetworkStores bool true
ok defaults com.apple.frameworks.diskimages skip-verify bool true
ok defaults com.apple.frameworks.diskimages skip-verify-remote bool true
ok defaults com.apple.frameworks.diskimages skip-verify-locked bool true

# don't prompt time machine on new disks
ok defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup bool true

# --- dock
ok defaults com.apple.dock autohide bool true
ok defaults com.apple.dock static-only bool true
ok defaults com.apple.dock workspaces-swoosh-animation-off bool true
ok defaults com.apple.dashboard mcx-disabled bool true
ok defaults com.apple.dock tilesize integer 36
# dock show/hide
ok defaults com.apple.dock autohide-delay float 0
ok defaults com.apple.dock autohide-time-modifier float 0
# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false
# top-left corner: start screen saver
ok defaults com.apple.dock wvous-tl-corner integer 5
ok defaults com.apple.dock wvous-tl-modifier integer 0
# Put it on the left
ok defaults com.apple.dock orientation string left
# clear the dock
# ok rm ~/Library/Application\ Support/Dock/*.db

# DIE DASHBOARD DIE
ok defaults com.apple.dashboard mcx-disabled bool true

# TODO: if changed...
# killall Dock

ok defaults com.apple.Finder FXPreferredViewStyle string clmv
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false
# ok defaults com.apple.finder EmptyTrashSecurely bool true
# show ~/Library
# chflags nohidden ~/Library
# TODO: if changed...
# killall Finder

# require password immediately on sleep or screensaver
ok defaults com.apple.screensaver askForPassword integer 1
ok defaults com.apple.screensaver askForPasswordDelay integer 0



# ---
# include apps.sh
ok cask alfred
ok cask crashplan
ok cask dropbox
ok cask google-drive
ok cask little-snitch
ok cask the-unarchiver

# ok cask daisydisk # via appstore
ok cask onepassword

#ok cask fantastical
ok cask google-chrome
ok cask google-hangouts
ok cask kindle
# ok cask pocket
ok cask vlc

ok cask adobe-creative-cloud
ok cask adobe-photoshop-lightroom
# ok cask search colorchooser
ok cask colorpicker-developer
ok cask gifrocket
ok cask fontprep
# ok cask pixelmator
# ok cask sketch
# ok cask sketchbook-pro
# ok cask xscope

# ok cask albeton-live
ok cask fission
ok cask cycling74-max

# ok cask calca
ok cask marked

ok cask atom
# ok cask dash
# ok cask duo
ok cask iterm2
ok cask vagrant
ok cask virtualbox
# ---
# include sketch.sh
sketch_dir="$HOME/Library/Containers/com.bohemiancoding.sketch3/Data/Library/Application Support/com.bohemiancoding.sketch3/"
ok directory $sketch_dir

destination push $sketch_dir
ok github timuric/Content-generator-sketch-plugin

destination pop
# ---
