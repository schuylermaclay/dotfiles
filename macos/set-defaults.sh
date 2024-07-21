#!/usr/bin/env bash

# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# https://macos-defaults.com/
#
# Run ./set-defaults.sh and you'll be good to go.

# above stolen from someone but I don't remember who. Sorry
# good resource: https://git.herrbischoff.com/awesome-macos-command-line/about/
# from man defaults: "Specify the global domain. '-g' and '-globalDomain' may be used as synonyms for NSGlobalDomain."

if echo "$OSTYPE" | grep -qv "darwin"; then
    exit 0
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

set -eux

# camelCase all the things, even -- incorrectly I might add -- camelCase.
# hostname="schuWorkM1"

hostname=$(hostname)
echo "Current hostname: $hostname"

# Ask the user if they want to change it
echo -n "Do you want to change the hostname? (y/n): "
read -r answer

if [ "$answer" == "y" ]; then
    # Prompt the user for a new name and change it
    echo "Enter a new hostname: "
    read -r new_hostname
    sudo scutil --set ComputerName "$new_hostname"
    sudo scutil --set HostName "$new_hostname"
    sudo scutil --set LocalHostName "$new_hostname"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$new_hostname"
fi

# hide spotlight menubar TODO disable completely?
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1

# go around Gatekeeper (lil risky I suppose)
defaults write com.apple.LaunchServices LSQuarantine -bool false

# iTerm
current_user=$(whoami)
iterm2_dir="/Users/$current_user/dotfiles/iterm"
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$iterm2_dir"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Dock
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.Dock size-immutable -bool true
defaults write com.apple.dock tilesize -int 33

# Prevent Time Machine from Prompting to Use New Hard Drives as Backup Volume
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Finder: Always open everything in Finder's list view. This is important.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv
# Show the ~/Library folder.
chflags nohidden ~/Library
# Show path
defaults write com.apple.finder ShowPathbar -bool true
# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
# Finder: show all filename extensions
defaults write -g AppleShowAllExtensions -bool true
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Hide Safari's bookmark bar.
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Set up Safari for development.
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write -g WebKitDeveloperExtras -bool true

# disable dumb definition shortcut
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 70 '<dict><key>enabled</key><false/></dict>'

# no .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Set a really fast key repeat.
# do this by hand with krp fork
# this one is good?

defaults write -g InitialKeyRepeat -int 10 # UI minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2         # UI minimum is 2 (30 ms)

# these are what I've been using
defaults write -g com.apple.mouse.scaling 2
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g NSWindowResizeTime -float 0.001

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# I'd love to figure out how to remove spaces/rename them, one idea here: https://henman.ca/2020/08/22/macos-screenshot-naming-format-has-changed/
# basically automated script that watches folder and renames files, might interfere with drag and drop though
# Save screenshots to the desktop
mkdir -p "${HOME}/Desktop/screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Desktop/screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# screensaver clock
defaults -currentHost write com.apple.ScreenSaver showClock -bool true

for app in "Activity Monitor" \
    "Contacts" \
    "Dock" \
    "Finder" \
    "Google Chrome" \
    "Messages" \
    "Photos" \
    "Safari" \
    "SystemUIServer" \
    "Terminal" \
    "Transmission" \
    "Tweetbot" \
    "Twitter" \
    "iCal"; do
    killall "${app}" &>/dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
