# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
ok defaults com.apple.finder QuitMenuItem bool true

# Finder: disable window animations and Get Info animations
ok defaults com.apple.finder DisableAllAnimations bool true

# Set Home Directory as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
ok defaults com.apple.finder NewWindowTarget string "PfHm"
ok defaults com.apple.finder NewWindowTargetPath string "file://${HOME}/"

# Show icons for hard drives, servers, and removable media on the desktop
ok defaults com.apple.finder ShowExternalHardDrivesOnDesktop bool true
ok defaults com.apple.finder ShowHardDrivesOnDesktop bool true
ok defaults com.apple.finder ShowMountedServersOnDesktop bool true
ok defaults com.apple.finder ShowRemovableMediaOnDesktop bool true

# Finder: show hidden files by default
#ok defaults com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
ok defaults NSGlobalDomain AppleShowAllExtensions bool true

# Finder: show status bar
ok defaults com.apple.finder ShowStatusBar bool true

# Finder: show path bar
ok defaults com.apple.finder ShowPathbar bool true

# Display full POSIX path as Finder window title
ok defaults com.apple.finder _FXShowPosixPathInTitle bool true

# Keep folders on top when sorting by name
ok defaults com.apple.finder _FXSortFoldersFirst bool true

# When performing a search, search the current folder by default
ok defaults com.apple.finder FXDefaultSearchScope string "SCcf"

# Disable the warning when changing a file extension
ok defaults com.apple.finder FXEnableExtensionChangeWarning bool false

# Enable spring loading for directories
ok defaults NSGlobalDomain com.apple.springing.enabled bool true

# Remove the spring loading delay for directories
ok defaults NSGlobalDomain com.apple.springing.delay float 0

# Avoid creating .DS_Store files on network volumes
ok defaults com.apple.desktopservices DSDontWriteNetworkStores bool true

# Disable disk image verification
ok defaults com.apple.frameworks.diskimages skip-verify bool true
ok defaults com.apple.frameworks.diskimages skip-verify-locked bool true
ok defaults com.apple.frameworks.diskimages skip-verify-remote bool true

# Automatically open a new Finder window when a volume is mounted
ok defaults com.apple.frameworks.diskimages auto-open-ro-root bool true
ok defaults com.apple.frameworks.diskimages auto-open-rw-root bool true
ok defaults com.apple.finder OpenWindowForNewRemovableDisk bool true

# Show item info near icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
#
# # Show item info to the right of the icons on the desktop
# /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
#
# # Enable snap-to-grid for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
#
# # Increase grid spacing for icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
#
# # Increase the size of icons on the desktop and in other icon views
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
# /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
ok defaults com.apple.finder FXPreferredViewStyle string "Nlsv"

# Disable the warning before emptying the Trash
ok defaults com.apple.finder WarnOnEmptyTrash bool false

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
ok defaults com.apple.NetworkBrowser BrowseAllInterfaces bool true

# Show the ~/Library folder
ok check "ls -lO ~ | grep Library"
if check_failed && satisfying; then
  chflags nohidden ~/Library
fi

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
ok defaults com.apple.finder FXInfoPanesExpanded dict General -bool true OpenWith -bool true Privileges -bool true
