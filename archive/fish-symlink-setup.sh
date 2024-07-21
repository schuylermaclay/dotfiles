#! /usr/bin/env sh

# https://github.com/rkalis/dotfiles/blob/master/fish/setup.sh
DIR=$(dirname "$0")
cd "$DIR"

. ../../scripts/functions.sh

# should have -m but realpath is fake
SOURCE="$(realpath ~/dotfiles/.config/fish)"
DESTINATION="$(realpath ~/.config/fish)"

info "Setting up fish shell..."

substep_info "Creating fish config folders..."
mkdir -p "$DESTINATION/functions"
mkdir -p "$DESTINATION/completions"
mkdir -p "$DESTINATION/conf.d"

# Find all .fish files in the target directory
target_files=$(find "$DESTINATION" \( -name "*.fish" -o -name "fish_plugins" -o -name "*.py" \))

# check if the file exists in the source directory but not in the target directory
for source_file in $SOURCE/functions/*; do
    target_file="$DESTINATION/functions/$(basename "$source_file")"
    if [ ! -e "$target_file" ]; then
        printf '%s\n' "target file: $target_file"
        cp "$source_file" "$target_file"
    fi
done

for file in $target_files; do
    # Get the relative path of the file TODO get real realpath
    relative_path=$(echo "$file" | sed "s|^$DESTINATION/||")
    # Check if the file exists in the source directory
    if [ ! -f "$relative_path" ]; then
        # Copy the file to the source directory
        # echo "$SOURCE/$relative_path"
        cp "$file" "$SOURCE/$relative_path"

        # Check if the cp command was successful (exit code 0)
        if [ $? -eq 0 ]; then
            info "Copied $file to $SOURCE/$relative_path"
            # Remove the original file only if cp was successful
            rm -f "$file"
            info "Removed $file"
        else
            warning "Failed to copy $file to $SOURCE/$relative_path"
        fi
    fi
done

find * \( -name "*.fish" -o -name "fish_plugins" -o -name "*.py" \) | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clear_broken_symlinks "$DESTINATION"

set_fish_shell() {
    # https://stackoverflow.com/questions/16375519/how-to-get-the-default-shell
    if dscl . -read ~/ UserShell | grep --quiet fish; then
        success "Fish shell is already set up."
    else
        substep_info "Adding fish executable to /etc/shells"
        if grep --fixed-strings --line-regexp --quiet "$(which fish)" /etc/shells; then
            substep_success "Fish executable already exists in /etc/shells."
        else
            if sudo bash -c "echo "$(which fish)" >> /etc/shells"; then
                substep_success "Fish executable added to /etc/shells."
            else
                substep_error "Failed adding Fish executable to /etc/shells."
                return 1
            fi
        fi
        substep_info "Changing shell to fish"
        if chsh -s "$(which fish)"; then
            substep_success "Changed shell to fish"
        else
            substep_error "Failed changing shell to fish"
            return 2
        fi
        substep_info "Running fish initial setup"
        fish -c "setup"
    fi
}

if set_fish_shell; then
    success "Successfully set up fish shell."
    # Check if fisher is installed in Fish shell
    if
        fish -c "type -s fisher" &
        >/dev/null
    then
        substep_success "Fisher is installed."
    else
        substep_info "Fisher is not installed. Installing..."
        # Install fisher
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fi
    # Run fisher install
    fish -c "fisher update"
else
    error "Failed setting up fish shell."
fi
