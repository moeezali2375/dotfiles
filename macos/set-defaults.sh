#!/usr/bin/env zsh

# ==============================================================================
# macOS System Settings Configuration
# ==============================================================================

# Close System Settings to prevent it from overriding changes
osascript -e 'tell application "System Settings" to quit' 2>/dev/null

echo "Applying macOS system preferences..."

# ------------------------------------------------------------------------------
# General UI / UX & Input
# ------------------------------------------------------------------------------

# Automatically switch between Light and Dark appearance
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# Prefer tabs when opening documents: Always
defaults write NSGlobalDomain AppleWindowTabbingMode -string "always"

# When switching to an application, don't switch to a Space with open windows for the application
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool false

# 24-Hour Time
defaults write NSGlobalDomain AppleICUForce24HourTime -bool true

# Fast Key Repeat and short Initial Delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard navigation (Tab key navigates all UI controls)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Show all filename extensions in Finder and standard file dialogs
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable auto-correct, auto-capitalization, smart quotes/dashes/periods
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false

# Trackpad speed and force click
defaults write NSGlobalDomain "com.apple.trackpad.scaling" -float 2
defaults write NSGlobalDomain "com.apple.trackpad.forceClick" -int 1

# Spring loading for directories
defaults write NSGlobalDomain "com.apple.springing.enabled" -bool true
defaults write NSGlobalDomain "com.apple.springing.delay" -float 0.5

# ------------------------------------------------------------------------------
# Modifier Key Remapping (Caps Lock -> Escape)
# ------------------------------------------------------------------------------
echo "Configuring Caps Lock to Escape mapping..."
# Persistent mapping across reboots for current host
defaults -currentHost write -g "com.apple.keyboard.modifiermapping.0-0-0" -array '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'
# Apply immediately to current session without requiring logout/reboot
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' &>/dev/null

# ------------------------------------------------------------------------------
# Trackpad Gestures
# ------------------------------------------------------------------------------

# Enable Tap to Click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1

# Enable two-finger secondary click
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -int 1

# Swipe & Pinch gestures
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadFiveFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerPinchGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFiveFingerPinchGesture -int 2

# ------------------------------------------------------------------------------
# Dock & Mission Control
# ------------------------------------------------------------------------------

# Position Dock on the left
defaults write com.apple.dock orientation -string "left"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Speed up auto-hide animation (0.15s)
defaults write com.apple.dock autohide-time-modifier -float 0.15

# Minimize windows into their application icon
defaults write com.apple.dock minimize-to-application -bool true

# Do not show recently used applications in Dock
defaults write com.apple.dock show-recents -bool false

# Do not automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Enable App Exposé gesture
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Bottom-right hot corner: Quick Note (14)
defaults write com.apple.dock wvous-br-corner -int 14

# Configure Dock Pinned Items & Stacks (if dockutil is installed)
if command -v dockutil &>/dev/null; then
    echo "Configuring pinned Dock apps and folder stacks..."
    dockutil --no-restart --remove all &>/dev/null

    # Pinned Apps
    DOCK_APPS=(
        "/System/Applications/Launchpad.app"
        "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
        "/Applications/Alacritty.app"
        "/System/Applications/Mail.app"
        "/System/Applications/Notes.app"
        "/System/Applications/System Settings.app"
        "/System/Applications/Spotify.app"
        "/System/Applications/Photos.app"
    )
    for app in "${DOCK_APPS[@]}"; do
        [ -e "$app" ] && dockutil --no-restart --add "$app" &>/dev/null
    done

    # Pinned Folder Stacks
    [ -d "${HOME}/Downloads" ] && dockutil --no-restart --add "${HOME}/Downloads" --view fan --display stack --sort dateadded &>/dev/null
    [ -d "${HOME}/Pictures/ScreenShots" ] && dockutil --no-restart --add "${HOME}/Pictures/ScreenShots" --view grid --display folder --sort name &>/dev/null
fi

# ------------------------------------------------------------------------------
# Window Manager / Desktop & Stage Manager
# ------------------------------------------------------------------------------

# Click wallpaper to reveal desktop: Disabled (Only in Stage Manager)
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false

# Hide desktop items (icons)
defaults write com.apple.WindowManager HideDesktop -bool true

# Disable window edge snapping / tiling by dragging to edges
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTilingOptionAccelerator -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false

# ------------------------------------------------------------------------------
# Finder
# ------------------------------------------------------------------------------

# Default view style in Finder: List View (Nlsv)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Automatically empty bin after 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Set default location for new Finder windows to ~/Downloads
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Desktop icons: show hard drives, external drives, and removable media
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show sidebar, preview pane, and expanded sections
defaults write com.apple.finder ShowSidebar -bool true
defaults write com.apple.finder ShowPreviewPane -bool true
defaults write com.apple.finder SidebarDevicesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarPlacesSectionDisclosedState -bool true
defaults write com.apple.finder SidebarTagsSctionDisclosedState -bool true
defaults write com.apple.finder SidebarWidth2 -int 225

# ------------------------------------------------------------------------------
# Screenshots
# ------------------------------------------------------------------------------

# Prepend device name to screenshot filenames (e.g., "Moeez Ali V5 2026-08-29 at ...")
DEVICE_NAME="$(scutil --get ComputerName 2>/dev/null || hostname -s)"
defaults write com.apple.screencapture name -string "${DEVICE_NAME}"

# Custom screenshot save location
mkdir -p "${HOME}/Pictures/ScreenShots"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/ScreenShots"
defaults write com.apple.screencapture target -string "file"

# ------------------------------------------------------------------------------
# Menu Bar & Control Center
# ------------------------------------------------------------------------------

# Show battery percentage in Menu Bar
defaults -currentHost write com.apple.controlcenter BatteryShowPercentage -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Control Center Modules in Menu Bar
defaults -currentHost write com.apple.controlcenter Battery -int 8
defaults -currentHost write com.apple.controlcenter WiFi -int 8
defaults -currentHost write com.apple.controlcenter Spotlight -int 8
defaults write com.apple.controlcenter "NSStatusItem VisibleCC BentoBox-0" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC Clock" -bool true
defaults write com.apple.controlcenter "NSStatusItem VisibleCC NowPlaying" -bool true

# Show Day of the Week and AM/PM in Clock
defaults write com.apple.menuextra.clock ShowDate -int 0
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true

# ------------------------------------------------------------------------------
# Restart Affected Services
# ------------------------------------------------------------------------------
echo "Restarting affected system services (Dock, Finder, WindowManager, SystemUIServer)..."
for app in "Dock" "Finder" "SystemUIServer" "WindowManager" "ControlCenter"; do
    killall "${app}" &>/dev/null
done

echo "Done! macOS system settings applied."
echo "Note: Some keyboard and system-level settings may require a logout or restart to take full effect."
