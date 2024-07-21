#!/bin/bash

# thanks chatGPT
# nevermind, no workie

# Function to merge TOML files
merge_toml() {
    awk 'NF && !/^#/ { sub(/^\[.*\]$/, ""); gsub(/^[[:space:]]+|[[:space:]]+$/, ""); split($0, a, /=/); key=a[1]; value=a[2]; if (!(key in toml)) { toml[key] = value; } else { toml[key] = toml[key] ", " value; } } END { for (key in toml) { print key "=" toml[key]; } }' "$1" "$2"
}

# Check if correct number of arguments provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 file1.toml file2.toml"
    exit 1
fi

# Merge TOML files
merge_toml "$1" "$2"
