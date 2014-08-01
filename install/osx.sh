# TODO: perhaps pull inspiration from https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# auto-expand save, print dialogs
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode bool true
ok defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint bool true
ok defaults NSGlobalDomain PMPrintingExpandedStateForPrint2 bool true

# default to save to disk, not iCloud
ok defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud bool false

# disable gatekeeper
# ok defaults com.apple.LaunchServices LSQuarantine bool false

# speed up the UI
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001

# fix the UI
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
ok defaults NSGlobalDomain NSTableViewDefaultSizeMode int 2

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
ok defaults com.apple.dock orientation string bottom
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
ok defaults com.apple.screensaver askForPassword bool true
ok defaults com.apple.screensaver askForPasswordDelay integer 0


# show ascii-control characters using caret notation in text views
ok defaults NSGlobalDomain NSTextShowsControlCharacters bool true
