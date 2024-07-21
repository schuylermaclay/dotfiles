function lc --description 'claude, write a fish function lc that takes a path, if the argument is a file it does wc -l to print line count, if argument is not specified or a directory, do ls -1A | wc -l to print the number of files and directories'
    if test (count $argv) -eq 0
        # No argument provided, count files and directories in current directory
        echo (ls -1A | wc -l | string trim)
    else if test -f $argv[1]
        # Argument is a file, count lines
        wc -l $argv[1] | awk '{print $1}'
    else if test -d $argv[1]
        # Argument is a directory, count files and directories in it
        echo (ls -1A $argv[1] | wc -l | string trim)
    else
        # Argument is neither a file nor a directory
        echo "Error: '$argv[1]' is not a valid file or directory."
        return 1
    end
end
