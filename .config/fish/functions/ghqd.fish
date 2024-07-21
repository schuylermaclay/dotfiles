function ghqd -d "ghq get based on a url, ssh url, or org/name combo, reformats as ssh url, cd to boot"

    # inputs can be a repo org/name or https url or ssh url
    # git@github.com:x-motemen/ghq.git
    # https://github.com/x-motemen/ghq
    # x-motemen/ghq

    set -l RED '\033[0;31m'
    set -l NC '\033[0m'

    # variable for the rel path to the repo
    set -l repo_path
    # variable for ssh url to the repo
    set -l ssh_url

    # first check if the input is a url
    if echo $argv | grep -q "https://github.com"
        # echo "input is a url"
        #  if it is, set repo_path to the org/name
        set -l url_sans_query_params (string split -m 1 "?" $argv)[1]
        set repo_path (echo $url_sans_query_params | sed 's/https:\/\/github.com\///')
    else if echo $argv | grep -q "git@github.com"
        # echo "input is a ssh url"
        #  if it is, set repo_path to the org/name
        set -l half_stripped_ssh_url (echo $argv | sed 's/git@github.com://')
        set repo_path (echo $half_stripped_ssh_url | sed 's/.git//')
    else
        echo "input is not a url, assuming org/name format😕"
        # if it is not a url, set repo_path to the input
        # TODO sanitize input
        set repo_path $argv
    end

    # make ssh_url equal to 'git@github.com:' + repo_path + '.git'
    set ssh_url "git@github.com:$repo_path.git"

    set -l ghq_get_output (ghq get -p --no-recursive -u $ssh_url 2>&1 < /dev/null)
    # echo "ghq_get_output: $ghq_get_output"
    if string match -qir "already exists and is not an empty directory|fatal: Could not read from remote repository" "$ghq_get_output"
        echo (set_color brblue)"nice, you've already got this one, headed there now..."(set_color normal)
    else
        echo (set_color brblue)"nice, you've already got this one, headed there now..."(set_color normal)
    end

    # if path is subdir, not root, strip to org/name path
    set -l path_parts (string split / $repo_path)
    # echo "path_parts: $path_parts"
    set -l root_path (string join / $path_parts[1] $path_parts[2])
    # assume last part is a file, so drop it. if its a dir you will land up one level too high, 
    # lame but easier than parsing for file from url... me/myrepo/dir/subdir/file-with-no-extension-cant-be-differentiated from a dir
    #  oh hell forgot about the branch part of the url, this is a mess
    # set -l subdir_path (string join / $path_parts[3..-2])
    # echo "root_path: $root_path"
    # echo ghq list -p | grep $repo_path
    set -l abs_path (ghq list -p | grep $root_path)
    # echo "abs_path: $abs_path"
    cd $abs_path

    # end

end
