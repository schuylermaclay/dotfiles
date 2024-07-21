function gup -d "commit and push, message is 'update' unless otherwise specified"
    git add -A
    if test (git status 2> /dev/null ^&1 | tail -n1) != "nothing to commit (working directory clean)"
        if test -n "$argv[1]"
            git commit -m "$argv[1]"
        else
            git commit -m update
        end
    else
        echo "No changes to commit."
    end
    git push
end
