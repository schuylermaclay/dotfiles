#!/bin/sh

# usage: find . -type l -exec /path/tos/script {} +
# Set the shell to exit immediately if any command fails
set -e

# Loop through each argument passed to the script
for link; do
    # Check if the argument is a symbolic link. If not, continue to the next iteration.
    test -h "$link" || continue

    # Extract the directory portion of the link's path and store it in the variable 'dir'
    dir=$(dirname "$link")

    # Read the target of the symbolic link and store it in the variable 'reltarget'
    reltarget=$(readlink "$link")

    # Check whether the target of the symbolic link is an absolute path or a relative path
    case $reltarget in
        /*) abstarget=$reltarget;;  # If it's absolute, assign it directly to 'abstarget'
        *)  abstarget=$dir/$reltarget;;  # If it's relative, construct the absolute path
    esac

    # Remove the existing symbolic link with verbosity and force if necessary
    rm -fv "$link"

    # Copy the target of the symbolic link to the link location with verbosity and preserving attributes.
    # If the copy operation fails, execute the code within {...}
    cp -afv "$abstarget" "$link" || {
        # Remove the partially copied link
        rm -rfv "$link"
        # Reinstate the original symbolic link using 'ln -sfv'
        ln -sfv "$reltarget" "$link"
    }
done
