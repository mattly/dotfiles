bork_any_updated=0

ok defaults com.apple.dock autohide bool true
ok defaults com.apple.dock tilesize float 36
ok defaults com.apple.dock orientation string "left"

# animations
ok defaults com.apple.dock static-only bool true
ok defaults com.apple.dock workspaces-swoosh-animation-off bool true
ok defaults com.apple.dock mineffect string "scale"
ok defaults com.apple.dock autohide-delay float 0
ok defaults com.apple.dock autohide-time-modifier float 0
ok defaults com.apple.dock no-bouncing int 0
ok defaults com.apple.dock launchanim bool false

# minimize windows to application
ok defaults com.apple.dock minimize-to-application bool true
# Enable spring loading for all items
ok defaults com.apple.dock enable-spring-load-actions-on-all-items bool true
# Show indicatior lights for open apps
ok defaults com.apple.dock show-process-indicators bool true
# Make icon of hidden apps translucent
ok defaults com.apple.dock showhidden bool true
# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

###### Other Things
# don't re-order spaces in mission control
ok defaults com.apple.dock mru-spaces bool false

ok defaults com.apple.dock expose-animation-duration float 0.1
# Disable Dashboard
ok defaults com.apple.dashboard mcx-disabled bool true

# top-left corner: start screen saver
ok defaults com.apple.dock wvous-tl-corner integer 5
ok defaults com.apple.dock wvous-tl-modifier integer 0

if any_updated; then
  killall Dock
fi
