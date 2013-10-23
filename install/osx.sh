# auto-expand save, print dialogs
defaults NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# default to save to disk, not iCloud
defaults NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# speed up the UI
defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults NSGlobalDomain NSWindowResizeTime .001
# fix the UI
defaults NSGlobalDomain AppleEnableMenuBarTransparency -bool false
# show all extensions
defaults NSGlobalDomain AppleShowAllExtensions -bool true
# disable auto spelling correction
defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

defaults com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults com.apple.frameworks.diskimages skip-verify -bool true
defaults com.apple.frameworks.diskimages skip-verify-remote -bool true
defaults com.apple.frameworks.diskimages skip-verify-locked -bool true

defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

defaults com.apple.dock autohide -bool true
defaults com.apple.dock static-only -bool true
defaults com.apple.dock workspaces-swoosh-animation-off -bool true
defaults com.apple.dashboard mcx-disabled -bool true
defaults com.apple.dock tilesize -int 36
# dock show/hide
defaults com.apple.dock autohide-delay -float 0
defaults com.apple.dock autohide-time-modifier -float 0
# don't re-order spaces in mission control
defaults com.apple.dock mru-spaces -bool false
# top-left corner: start screen saver
defaults com.apple.dock wvous-tl-corner -int 5
defaults com.apple.dock wvous-tl-modifier -int 0
# Put it on the left
defaults com.apple.dock orientation -string left
# clear the dock
rm ~/Library/Application\ Support/Dock/*.db

# DIE DASHBOARD DIE
defaults com.apple.dashboard mcx-disabled -boolean YES

# TODO: if changed...
killall Dock

defaults com.apple.Finder FXPreferredViewStyle clmv
defaults com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults com.apple.finder EmptyTrashSecurely -bool true
# show ~/Library
chflags nohidden ~/Library
# TODO: if changed...
killall Finder

# require password immediately on sleep or screensaver
defaults com.apple.screensaver askForPassword -int 1
defaults com.apple.screensaver askForPasswordDelay -int 0



