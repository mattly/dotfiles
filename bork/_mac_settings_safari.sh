bork_any_updated=0

# Privacy: don’t send search queries to Apple
ok defaults com.apple.Safari UniversalSearchEnabled bool false
ok defaults com.apple.Safari SuppressSearchSuggestions bool true

# Show the full URL in the address bar (note: this still hides the scheme)
ok defaults com.apple.Safari ShowFullURLInSmartSearchField bool true

# Set Safari’s home page to `about:blank` for faster loading
ok defaults com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening ‘safe’ files automatically after downloading
ok defaults com.apple.Safari AutoOpenSafeDownloads bool false

# Hide Safari’s bookmarks bar by default
ok defaults com.apple.Safari ShowFavoritesBar bool false

# Hide Safari’s sidebar in Top Sites
ok defaults com.apple.Safari ShowSidebarInTopSites bool false

# Disable Safari’s thumbnail cache for History and Top Sites
ok defaults com.apple.Safari DebugSnapshotsUpdatePolicy int 2

# Enable Safari’s debug menu
ok defaults com.apple.Safari IncludeInternalDebugMenu bool true

# Make Safari’s search banners default to Contains instead of Starts With
ok defaults com.apple.Safari FindOnPageMatchesWordStartsOnly bool false

# Enable the Develop menu and the Web Inspector in Safari
ok defaults com.apple.Safari IncludeDevelopMenu bool true
ok defaults com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey bool true
ok defaults com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled bool true

# Add a context menu item for showing the Web Inspector in web views
ok defaults NSGlobalDomain WebKitDeveloperExtras bool true

# Enable continuous spellchecking
ok defaults com.apple.Safari WebContinuousSpellCheckingEnabled bool true
# Disable auto-correct
ok defaults com.apple.Safari WebAutomaticSpellingCorrectionEnabled bool false

# Disable AutoFill
ok defaults com.apple.Safari AutoFillFromAddressBook bool false
ok defaults com.apple.Safari AutoFillPasswords bool false
ok defaults com.apple.Safari AutoFillCreditCardData bool false
ok defaults com.apple.Safari AutoFillMiscellaneousForms bool false

# Warn about fraudulent websites
ok defaults com.apple.Safari WarnAboutFraudulentWebsites bool true

# Disable plug-ins
ok defaults com.apple.Safari WebKitPluginsEnabled bool false
ok defaults com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled bool false

# Disable Java
ok defaults com.apple.Safari WebKitJavaEnabled bool false
ok defaults com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled bool false

# Block pop-up windows
ok defaults com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically bool false
ok defaults com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically bool false

# Enable “Do Not Track”
ok defaults com.apple.Safari SendDoNotTrackHTTPHeader bool true

# Update extensions automatically
ok defaults com.apple.Safari InstallExtensionUpdatesAutomatically bool true

if any_updated; then
  killall Finder
fi
