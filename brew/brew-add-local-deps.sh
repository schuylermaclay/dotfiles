#!/bin/sh

# Sourcing functions from scripts/functions.sh
. ./scripts/functions.sh

info "Checking and installing Brew"
command -v brew >/dev/null 2>&1 || {
    echo >&2 "Installing Homebrew Now"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

cd ~/dotfiles

# define source, target and output files
source_file="Brewfile.temp"
target_file="Brewfile"
output_file="Brewfile.test"

substep_info "Dumping Temporary Brewfile"
brew bundle dump --file "$source_file"

# read each line of source file and append it to target if it doesn't exist
while IFS= read -r line_from_temp; do
    # info "Checking $line_from_temp"xs
    # Check if the package is already in Brewfile
    if ! grep -q "^$line_from_temp$" $target_file; then
        info "Not found in main $target_file: $line_from_temp -------------"
        # append line from temp to target here
        echo "$line_from_temp" >> "$target_file"
    fi
done <$source_file

# read in the target file and put each line in an array for that section

# array of the sections
declare -a sections=("tap_lines", "bre_lines", "cas_lines", "mas_lines", "vsc_lines", "oth_lines") 

# all lines that start with tap
declare -a tap_lines=()
# all lines that start with bre
declare -a bre_lines=()
# all lines that start with cas
declare -a cas_lines=()
# all lines that start with mas
declare -a mas_lines=()
# all lines that start with vsc
declare -a vsc_lines=()
# other lines 
declare -a oth_lines=()

# sort lines into correct array here, ignoring blank lines
while IFS= read -r line; do
    # sort here
    if [[ $line == "tap"* ]]; then
        tap_lines+=("$line")
    elif [[ $line == "bre"* ]]; then
        bre_lines+=("$line")
    elif [[ $line == "cas"* ]]; then
        cas_lines+=("$line")
    elif [[ $line == "mas"* ]]; then
        mas_lines+=("$line")
    elif [[ $line == "vsc"* ]]; then
        vsc_lines+=("$line")
    else
        oth_lines+=("$line")
    fi

done <$target_file

# alphabetize each section and add a newline after each section
for section in "${sections[@]}"; do
    # sort the section
    IFS=$'\n' sorted=($(sort <<<"${section[*]}"))
    # add a newline after each section
    sorted+=("\n")
done

# output the sorted sections to the output file
for section in "${sections[@]}"; do
    for line in "${section[@]}"; do
        echo "$line" >> "$output_file"
    done
done



# rm -rfv $source_file
success "Done"
