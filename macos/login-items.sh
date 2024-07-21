#!/usr/bin/env bash

# Add things to login items
#
# Sauce:
#   https://gist.github.com/kaloprominat/6111584
#
# alternative is to use launchd/launchctl/plists, more info: https://www.macstadium.com/blog/automating-login-and-startup-events-in-macos
# this don't seem to work, or at least the Alfred 5 one doesn't work

if echo "$OSTYPE" | grep -qv "darwin"; then
    exit 0
fi

set -eux

# List login items
osascript -e 'tell application "System Events" to get the name of every login item'

# Add login item
osascript -e 'tell application "System Events" to make login item at end with properties {name: "iTerm",path:"/Applications/iTerm.app", hidden:false}'
osascript -e 'tell application "System Events" to make login item at end with properties {name: "Alfred 5",path:"/Applications/Alfred 5.app", hidden:false}'

# delete login item
# osascript -e 'tell application "System Events" to delete login item "itemname"'
