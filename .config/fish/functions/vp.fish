function vp --description 'save clipboard to file and open in vim, $argv[1] is the filename, defaults to /tmp/clipboard_YYYYMMDD_HHMMSS.txt'
    set filename $argv[1]

    # If no filename provided, create a temporary file
    if test -z "$filename"
        set filename "/tmp/clipboard_"(date +%Y%m%d_%H%M%S)".txt"
        echo "No filename provided. Using: $filename"
    end

    pbpaste >$filename

    if test $status -ne 0
        echo "Error: Failed to write clipboard contents to file"
        return 1
    end

    nvim $filename
end
