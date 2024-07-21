function ghqf -d "ghq create with follow and github init"

    set -l fish_trace 1
    # inputs not parsed in any way, passed straight to ghq create, 

    # TODO get user/vcs for abs path, breaks on name mo for example
    # figure out string weirdness

    # TODO just get status output
    echo $status
    set -l ghq_create_output (ghq create $argv 2>&1 </dev/null)
    echo $ghq_create_output
    echo $status
    # Clean the output by escaping non-printable characters
    # set -l clean_output (string escape -- $ghq_create_output)
    echo $status

    # Check if the command failed
    if test $status -ne 0
        echo $clean_output
        exit 1
    end

    # Echo the clean output if needed
    echo $clean_output

    if string match -qir "git init Initialized empty Git" "$ghq_create_output"
        echo (set_color brblue)"nice, a new repo, headed there now..."(set_color normal)
        set -l repo_path (string split ' ' -- $ghq_create_output)[-1]
        cd $repo_path
    else if string match -qir "already exists" "$ghq_create_output"
        echo (set_color brcyan)"nice, you've already got this one, headed there now..."(set_color normal)
        set -l repo_path (ghq list -p | grep $argv)
        cd $repo_path
    else
        echo (set_color brred)"something went wrong, here's the output:"(set_color normal)
        echo $ghq_create_output
    end

end
