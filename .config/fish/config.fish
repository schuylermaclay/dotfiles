# this bad boy is a bit off a mess

# debugging: set fish_trace on, seems like debugger is a lie

### Path ###

fish_add_path ~//bin
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin

# go
fish_add_path (go env GOPATH)/bin

# GNU coreutils... can i add /opt/homebrew/opt/ to path?
if test -d /opt/homebrew/opt/coreutils/libexec/gnubin
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
end
# GNU findutils
if test -d /opt/homebrew/opt/findutils/libexec/gnubin
    fish_add_path /opt/homebrew/opt/findutils/libexec/gnubin
end
# GNU getopt
if test -d /opt/homebrew/opt/gnu-getopt/bin
    fish_add_path /opt/homebrew/opt/gnu-getopt/bin
end
# GNU grep
if test -d /opt/homebrew/opt/grep/libexec/gnubin
    fish_add_path /opt/homebrew/opt/grep/libexec/gnubin
end
# GNU indent
if test -d /opt/homebrew/opt/gnu-indent/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-indent/libexec/gnubin
end
# GNU awk
if test -d /opt/homebrew/opt/gawk/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gawk/libexec/gnubin
end
# GNU sed
if test -d /opt/homebrew/opt/gnu-sed/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-sed/libexec/gnubin
end
# GNU tar
if test -d /opt/homebrew/opt/gnu-tar/libexec/gnubin
    fish_add_path /opt/homebrew/opt/gnu-tar/libexec/gnubin
end

# do this last to prepend as much as possible, prepend is default but include anyway
fish_add_path --move --prepend "$ASDF_DIR/bin"
fish_add_path --move --prepend "$HOME/.asdf/shims"

if status --is-interactive && type -q asdf
    source (brew --prefix asdf)/libexec/asdf.fish
end

# this is what asdf says to do, but it doesn't move asdf to front of path if its already defined (and in my case behind system node)
# source /opt/homebrew/opt/asdf/libexec/asdf.fish

# keeping this here to remind me I might want to move abbreviations to their own file
# source ~/.config/fish/abbr.fish
# source ~/.config/fish/**/*.fish' # pretty sure this doesn't work

### Keybindings ###
# https://fishshell.com/docs/current/cmds/bind.html
bind \cf forward-bigword
bind \em __fish_man_page
bind \eC '__fzf_cd --hidden'


### Variables ###

# one day I will understand -x vs -gx vs -Ux here, one day...
# set -x is just EXPORT in bash
# https://fishshell.com/docs/current/cmds/set.html

# Go
set -gx GOPATH (go env GOPATH)

# Homebrew
if test -d /usr/local/sbin
    set PATH /usr/local/sbin $PATH
end

# Editor
set -gx EDITOR code
set -gx VISUAL code

# Locale
set -gx LANGUAGE "en_US.UTF-8"
set -gx LC_ALL "en_US.UTF-8"
set -gx LANG "en_US.UTF-8"

# Homebrew
set -gx HOMEBREW_NO_ANALYTICS 1

# no .lesshst
set -gx LESSHISTFILE -
# better less
set -gx LESS -sFXR
# Pretty sure this unneeded and or only works for GNU ls
set -gx LSCOLORS Cxbgdxdxbxdgeghegeacad

set -gx RIPGREP_CONFIG_PATH "$HOME/.config/.ripgreprc"

# FZF
set -gx FZF_DEFAULT_COMMAND "fd -uuu --exclude /private/var --exclude /private/tmp --exclude /System/Volumes/Data --color always"
set -gx FZF_DEFAULT_OPTS --ansi --height=70%
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_CTRL_T_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
set -gx FZF_CTRL_R_OPTS "
  --history-size=10000
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
set -gx FZF_ALT_C_OPTS "
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

# set -gx RIP_GRAVEYARD = "$HOME/.spooky-graveyard"


### Abbreviations ###

# clear existing abbreviations... why? freshness.
for abbreviation in (abbr -l)
    abbr -e $abbreviation
end

# (from docs) Navigation .. ... .... ..... ...... ....... ........ ......... .......... ........... ............ ............. .............. ............... ................ .................. ................... .................... ..................... ...................... ....................... ........................ .........................
function multicd
    echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
end
abbr --add dotdot --regex '^\.\.+$' --function multicd

# cd - with just '-'
abbr --add cdminus --regex '^-' 'cd -'

# recent time machine logs
abbr --add tmlogs "printf '\e[3J' && log show --predicate 'subsystem == \"com.apple.TimeMachine\"' --info --last 6h | grep -F 'eMac' | grep -Fv 'etat' | awk -F']' '{print substr(\$0,1,19), \$NF}'"
#  raw clipboard contents
abbr --add pbraw 'osascript -e "the clipboard as record" | less'
# Recursively delete `.DS_Store` files
abbr --add dsstore_purge --position anywhere 'find . -name "*.DS_Store" -type f -ls -delete'
# Get total size of cdk.out dirs in CWD, recursively
abbr --add cdkout_usage --position anywhere 'fd cdk.out . -td -u -x du -cb {} | grep total | awk \'{ sum += $1 } END { print sum }\' | numfmt --to=iec-i'
# flush dns cache
abbr --add flushdns --position anywhere 'sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder'
# show recent downloads
abbr --add downloads --position anywhere 'eza --long --all --octal-permissions --flags --links --smart-group --hyperlink --sort=modified --reverse --color=always ~/Downloads | head -n 10'
# fd exclude rip dirs
abbr --add fde --position anywhere --set-cursor 'fd "%" / -uuu --exclude /private/var --exclude /private/tmp --exclude /System/Volumes/Data --color always'
# fd exclude rip dirs, quote output for easier copy paste
abbr --add fdequote --position anywhere --set-cursor 'fd "%" / -uuu --exclude /private/var --exclude /private/tmp --exclude /System/Volumes/Data -X printf "%q\n"'

#  brew bundle install
abbr --add bbi --set-cursor=! 'brew bundle install --file ~/dotfiles/brew/Brewfile! --zap --no-lock --no-upgrade --cleanup'
#  brew bundle dump
abbr --add bbd --set-cursor=! 'brew bundle dump --file ~/dotfiles/brew/Brewfile! --force --no-restart --all'
# brew cask upgrade
abbr --add bcu 'brew cu --all --cleanup --include-mas --force --no-quarantine --yes'

# abbr --add g git
abbr --add gs 'git status'
abbr --add gc 'git commit -v'
abbr --add gp 'git push'
abbr --add gl 'git pull'
abbr --add gco 'git checkout'
abbr --add gba 'git branch -vv --all'
abbr --add gfa 'git fetch --all'

abbr --add mv 'mv -v'
abbr --add mans --position anywhere 'man -aw'
abbr --add pppath --position anywhere 'printf "%s\n" $PATH'
abbr --add cmx --position anywhere 'chmod a+x '
abbr --add rr --position anywhere 'rm -rfv'
abbr --add ll --position anywhere 'eza --long --all --icons=always --header --git --octal-permissions --flags --links --smart-group --hyperlink --group-directories-first --sort=Name --time-style=long-iso'
abbr --add lt --position anywhere 'eza --long --all --icons=always --git --header --smart-group --hyperlink --group-directories-first --sort=Name --time-style=long-iso --git-ignore --ignore-glob="node_modules" --tree'
abbr --add lr --position anywhere 'eza --long --all --icons=always --header --git --octal-permissions --flags --links --smart-group --hyperlink --group-directories-first --sort=accessed --reverse --time-style=long-iso'

# abbr --add bs --position anywhere 'brew services'
# abbr --add lunchcontrol --position anywhere 'launchctl'

# dead links
abbr --add deadlinks --position anywhere 'fd -L -tl'

# venv
abbr --add venvenv 'python3 -m venv .venv
source .venv/bin/activate.fish
pip install --upgrade pip'

# edit vimrc
abbr --add --position anywhere ev 'vim ~/.vimrc'

abbr --add myip 'dig +short myip.opendns.com @resolver1.opendns.com'

# (from docs) L will be replaced with | less, placing the cursor before the pipe.
abbr --add L --position anywhere --set-cursor "% | less"

#  bang bang (last command)
function last_history_item
    echo $history[1]
end
abbr --add !! --position anywhere --function last_history_item

# bang boom (last args) - i truly don't understand what history-token-search-backward is or does but it seems to work
function last_history_args
    commandline -f history-token-search-backward
end
abbr --add !\$ --position anywhere --function last_history_args

# (from docs) do in all dirs
abbr --add fordirs --set-cursor=! "$(string join \n -- 'for dir in */' 'cd $dir' '!' 'cd ..' 'end')"


# relaod!: TODO better gif, moar gif
abbr --add relo --position anywhere "$(string join \n -- 'source ~/.config/fish/config.fish' 'chafa --duration 3 --speed 1 --align hcenter --size 120x120 ~/dotfiles/assets/reload-dune-zendaya.gif' 'fish_greeting')"
# faster reload
abbr --add r --position anywhere 'source ~/.config/fish/config.fish; fish_greeting'

alias g=git
alias v=nvim

alias brupdate="brew update && brew upgrade --force-bottle && brew autoremove && brew cleanup --prune 1 -v && brew doctor -v || true && brew cu --all --cleanup --include-mas --force --no-quarantine --yes"

### Source all the things ###

# not sure why brew puts grc in diff places on diff machines, shrug
if test -d /usr/local/etc/grc.fish
    source /usr/local/etc/grc.fish
end
if test -d /opt/homebrew/etc/grc.fish
    source /opt/homebrew/etc/grc.fish
end

fzf --fish | source
zoxide init fish | source
starship init fish | source
direnv hook fish | source
