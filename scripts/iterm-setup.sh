#!/bin/bash

# TODO ~ no workie here
DOTFILES="$HOME/dotfiles"

if [ -d "/Applications/iTerm.app" ]; then
    echo "Setting up iTerm2 preferences..."

    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$DOTFILES/iterm"

    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

    # automatic save
    defaults write com.googlecode.iterm2.plist NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
fi
