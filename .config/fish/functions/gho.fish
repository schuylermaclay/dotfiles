function gho --description 'open github'

    echo "Opening GitHub in Google Chrome..."

    # Get the repository URL
    set repo_url (git ls-remote --get-url origin)

    # Remove "git@" and ".git" from the URL
    set formatted_url (echo $repo_url | sed 's/git@//; s/\.git$//')

    # Replace ":" with "/" and prepend "https://"
    set formatted_url "https://"(string replace ":" "/" $formatted_url)

    # Open the URL in Google Chrome
    open -n -a "Google Chrome" $formatted_url

end
