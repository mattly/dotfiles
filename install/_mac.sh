ok check "fdesetup status | grep 'On'"
if check_failed; then
    echo "Filevault is not setup. Please enable filevault before continuing."
    open "/System/Library/PreferencePanes/Security.prefpane"
    exit 1
fi
if [ -n "$computer_name" ]; then
ok scutil ComputerName $computer_name
ok scutil HostName $computer_name
ok scutil LocalHostName $computer_name
fi

ok directory "$HOME/.ssh"
ok check "[ -e $HOME/.ssh/*.pub ]"
if check_failed && satisfying; then
    echo "Generating SSH Key"
    ssh-keygen -t rsa
fi

ok brew
ok brew git

ok directory "$HOME/code/mattly"
ok github $HOME/code/mattly/dotfiles mattly/dotfiles
cd ~
for config in $HOME/code/mattly/dotfiles/configs/*; do
    ok symlink ".$(basename $config)" $config
done
ok github ~/.emacs.d syl20bnr/spacemacs

ok brew tig

ok brew fish
register shells.sh
ok shells /usr/local/bin/fish
did_install && chsh -s /usr/local/bin/fish

ok brew curl
ok brew editorconfig
ok brew jq
ok brew the_silver_searcher

ok brew-tap caskroom/cask
ok brew brew-cask

ok cask 1password
ok cask dropbox
ok cask google-chrome
ok cask google-drive
ok cask the-unarchiver

ok brew-tap railwaycat/emacsmacport
ok brew emacs-mac

ok brew-tap argon/mas
ok brew mas

ok mas 477670270 2Do
ok mas 687450044 Blind
ok mas 458034879 Dash
ok mas 777886035 Duo
ok cask fantastical
ok cask iterm2
ok mas 540348655 Monosnap
ok cask paw
ok cask screenflow
ok mas 507257563 Sip
ok mas 803453959 Slack

# TODO: perhaps pull inspiration from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# login window security
ok defaults com.apple.loginwindow ShutDownDisabled bool true
ok defaults com.apple.loginwindow RestartDisabled bool true
ok defaults com.apple.loginwindow DisableConsoleAccess bool true

# auto-expand save
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true
# save to disk
ok defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false

# auto-expand print
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint2 bool true

# disable gatekeeper
# ok defaults com.apple.LaunchServices LSQuarantine bool false

# UI fixes
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
ok defaults NSGlobalDomain NSTableViewDefaultSizeMode integer 2

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
ok defaults com.apple.dock tilesize float 42
# dock show/hide
ok defaults com.apple.dock autohide-delay float 0
ok defaults com.apple.dock autohide-time-modifier float 0
# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false
# top-left corner: start screen saver
ok defaults com.apple.dock wvous-tl-corner integer 5
ok defaults com.apple.dock wvous-tl-modifier integer 0
# Put it on the left
ok defaults com.apple.dock orientation string bottom
# clear the dock
# ok rm ~/Library/Application\ Support/Dock/*.db

# DIE DASHBOARD DIE
ok defaults com.apple.dashboard mcx-disabled bool true

# TODO: if changed...
# killall Dock

ok defaults com.apple.Finder FXPreferredViewStyle string Nlsv
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false
# ok defaults com.apple.finder EmptyTrashSecurely bool true
# show ~/Library
# chflags nohidden ~/Library
# TODO: if changed...
# killall Finder

# require password immediately on sleep or screensaver
ok defaults com.apple.screensaver askForPassword bool true
ok defaults com.apple.screensaver askForPasswordDelay integer 0


# show ascii-control characters using caret notation in text views
ok defaults NSGlobalDomain NSTextShowsControlCharacters bool true
