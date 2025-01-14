#!/usr/bin/env bash

cd "$(dirname "$0")/.." || exit
DOTFILES_ROOT=$(pwd)

echo "• Installing Hammerspoon's dotfiles"

# Backup an existing dir if any
HSDIR=$HOME/.hammerspoon
if [[ -d "$HSDIR" ]]; then
    echo "• Backing up ~/.hammerspoon directory"
    mv -v "$HSDIR" "$HSDIR.bak"
fi
# Symlink .hammerspoon
ln -s -F -i "$DOTFILES_ROOT/hammerspoon/hammerspoon.symlink" "$HSDIR"
