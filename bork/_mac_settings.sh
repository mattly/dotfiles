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

# UI fixes
ok defaults NSGlobalDomain NSAutomaticWindowAnimationsEnabled bool false
ok defaults NSGlobalDomain NSWindowResizeTime string .001
ok defaults NSGlobalDomain AppleEnableMenuBarTransparency bool false
ok defaults NSGlobalDomain AppleInterfaceStyle string "Dark"
ok defaults NSGlobalDomain NSTableViewDefaultSizeMode integer 2

# disable auto spelling correction
ok defaults NSGlobalDomain NSAutomaticSpellingCorrectionEnabled bool false

# don't prompt time machine on new disks
ok defaults com.apple.TimeMachine DoNotOfferNewDisksForBackup bool true

# Require password immediately after sleep or screen saver begins
ok defaults com.apple.screensaver askForPassword -int 1
ok defaults com.apple.screensaver askForPasswordDelay -int 0

include _mac_settings_dock.sh
include _mac_settings_finder.sh
include _mac_settings_safari.sh

##### Tweetbot
# Bypass the annoyingly slow t.co URL shortener
# ok defaults com.tapbots.TweetbotMac OpenURLsDirectly bool true
