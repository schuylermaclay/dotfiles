#!/bin/sh

# Sourcing functions from scripts/functions.sh
. ./scripts/functions.sh

info "Checking and installing Brew"
command -v brew >/dev/null 2>&1 || {
    echo >&2 "Installing Homebrew Now"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

substep_info "Dumping Temporary Brewfile"
brew bundle dump --file Brewfile.temp

# Read each package from Brewfile.temp
while IFS= read -r line_from_temp; do
    info "Checking $line_from_temp"xs
    # Check if the package is already in Brewfile
    if ! grep -q "^$line_from_temp$" Brewfile; then
        info "Not found in main Brewfile: $line_from_temp -------------"
        # now where do we put it? alpha? by section. then random. one day alpha
        # Extract the first three letters of the line
        prefix_temp=$(echo $line_from_temp | cut -c 1-3)
        substep_info "Prefix: $prefix_temp"
        # Find the last line that starts with the same three letters
        last_line=$(grep "^$prefix_temp" Brewfile | tail -n 1)
        # last line of section found, append to end of section
        substep_info "Last Line: $last_line"
        # If a matching line is found, insert the package after it
        if [ -n "$last_line" ]; then
            substep_info "Inserting \"$line_from_temp\" after: \"$last_line\""
            # Escape special characters in $last_line and $line_from_temp
            escaped_last_line=$(printf '%s\n' "$last_line" | sed 's/[&/]/\\&/g')
            escaped_newline=$(printf '%s\n' "$line_from_temp" | sed 's/[&/]/\\&/g')

            # Construct the sed command with variables
            sed_command="s/($escaped_last_line)/\1\n$escaped_newline/"
            info "sed command: \n$sed_command"
            # Execute the sed command with the constructed expression
            sed -i'' -E "$sed_command" Brewfile

        else
            # If no matching line is found, append the package to the end of Brewfile
            info "Sort failed, Appending \"$line_from_temp\" to the end of Brewfile"
            echo "$line_from_temp" >>Brewfile
        fi
    fi
done <Brewfile.temp
rm -rfv Brewfile.temp
success "Done"
