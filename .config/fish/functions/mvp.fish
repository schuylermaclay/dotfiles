function mvp -d "(2) mkdir -p then mv file to dir. i.e. mvp file path/to/new/dir, does some deleting to allow simlutaneous move and rename"
    # "If the source_file ends in a /, the contents of the directory are copied rather than the directory itself."
    if test -z "$argv[1]"
        or test -z "$argv[2]"
        echo "Usage: mvp file path/to/new/dir"
        return 1
    end

    mkdir -pv $argv[2]
    cp -rvpn $argv[1]/. $argv[2] && rm -rf $argv[1]
end
