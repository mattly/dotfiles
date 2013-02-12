#!/bin/sh

# expanded mode for open/save/print dialogs
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# speed up UI
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime .001

# show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock static-only -bool TRUE

defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

for app in Finder Dock; do
  killall "$app" > /dev/null 2>&1
done
