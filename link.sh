#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# ignore ~/Library/Application Support/Code/User/snippets/{language}.json
############################

. "$HOME/dotfiles/scripts/functions.sh"

########## Variables

dotDir="$HOME/dotfiles"
# watch out for trailing whitespace
files="
.bashrc
.bash_profile
.vimrc
.vim
.inputrc
.gitconfig
.gitignore
.config/starship.toml
Library/Application Support/Code/User/settings.json
Library/Application Support/Code/User/keybindings.json
.config/karabiner
.config/fish
.config/alacritty
.config/nvim
.tmux.conf
.tool-versions
.config/.ripgreprc
bin
"

##########

OIFS="$IFS"
IFS=$'\n'

# Change to the dotfiles directory
info "Changing to the $dotDir directory ..."
if ! cd "$dotDir"; then
  error "Failed to change directory. Aborting." >&2
  exit 1
fi

changeCount=0

# Move any existing dotfiles in homedir to dotfiles directory as backup, then create symlinks
for file in $files; do
  info "Processing $file"
  # detect if symlink
  if [ -L "$HOME/$file" ]; then
    # check if the symlink points to the correct file
    if [ "$(readlink "$HOME/$file")" = "$dotDir/$file" ]; then
      substep_info "Correct symlink found"
      continue
    else
      substep_error "Incorrect symlink found, backing up..."
      mv -v "$HOME/$file" "$dotDir/${file}.backup.$(date +"%Y%m%d%H%M%S")"
    fi
  fi
  # detect if any file exists
  if [ ! -e "$HOME/$file" ]; then
    success "No file exists, creating symlink..."
  fi
  if [ -e "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
    success "Existing non-symlink file found, backing up"
    mv -v "$HOME/$file" "$dotDir/${file}.backup.$(date +"%Y%m%d%H%M%S")"
  fi

  changeCount=$((changeCount + 1))
  # Create symlink
  ln -svfn "$dotDir/$file" "$HOME/$file"
done
# TODO check for symlinks without traversing whole home dir
# clear_broken_symlinks $HOME
IFS="$OIFS"
substep_success "All done. $changeCount changes made."
