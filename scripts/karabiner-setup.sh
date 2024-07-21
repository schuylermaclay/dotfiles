#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR" || exit

# shellcheck source=/dev/null
. ./functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/karabiner)"

info "Setting up Karabiner Elements..."

substep_info "Creating Karabiner Elements folder..."
mkdir -p "$DESTINATION"

find * -name "*.json" | while read -r fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

success "Finished setting up Karabiner Elements."
