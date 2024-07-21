export _Z_OWNER='schu'
# . /opt/homebrew/etc/profile.d/z.sh
alias docker="/Applications/Docker.app/Contents/Resources/bin/docker"

if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
  . "$(brew --prefix)"/etc/bash_completion
fi

if [ -f ~/.config/git/git-prompt.sh ]; then
  . ~/.config/git/git-prompt.sh
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Aliases
# LS
# alias l='ls -lah'
# alias ll='ls -GoAh'
alias lol='ls -GlahT | lolcat -t'
alias vi='vim'
alias lcd=changeDirectory
# Git
alias gcl="git clone"
alias gs="git status"
alias gl="git pull"
alias gp="git push"
alias gd="git diff | mate"
alias gm="git commit -m"
alias gb="git branch"
alias gba="git branch -a"
alias gcam="git commit -am"
alias gco="git checkout"
alias gbd="git branch -d"
alias glr="git pull --rebase"
# alias ghb="hub browse"
# alias gup="git add . && git commit -m 'update' && git push"

alias r="source ~/.bashrc && printf \"Yup, go for it\"  | lolcat"

function gho() {
  echo "Opening GitHub in Google Chrome..."
  # Get the repository URL
  repo_url=$(git ls-remote --get-url origin)

  # Remove "git@" and ".git" from the URL
  formatted_url=$(echo "$repo_url" | sed 's/git@//; s/\.git$//')

  # Replace ":" with "/" and prepend "https://"
  formatted_url="https://${formatted_url/:/\//}"

  # Open the URL in Google Chrome
  open -n -a "Google Chrome" "$formatted_url"
}

# zf
if [ -d ~/.bash_completion.d ]; then
  for file in ~/.bash_completion.d/*; do
    . "$file"
  done
fi

function gup() {
  git add -A
  if [ -n "$(git status --porcelain)" ]; then
    if [ -n "$1" ]; then
      git commit -m "$1"
    else
      git commit -m "update"
    fi
  else
    echo "No changes to commit."
  fi
  git push
}

function mcd() {
  mkdir -p "$1"
  cd "$1" || exit
}
function epb() {
  pbpaste | vim -
}
sf() {
  if [ "$#" -lt 1 ]; then
    echo "Supply string to search for!"
    return 1
  fi
  printf -v search "%q" "$*"
  include="yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files="$(eval "$rg_command" "$search" | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}')"
  [[ -n "${files}" ]] && ${EDITOR:-vim} "$files"
}

bind "set completion-ignore-case on"
# export HISTCONTROL=ignoreboth:erasedups
# Set history length
HISTFILESIZE=1000000000
HISTSIZE=1000000
# Append to the history file, don't overwrite it
shopt -s histappend
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# Autocorrect typos in path names when using `cd`
shopt -s cdspell
# Save all lines of a multiple-line command in the same history entry (allows easy re-editing of multi-line commands)
shopt -s cmdhist
# Do not autocomplete when accidentally pressing Tab on an empty line. (It takes forever and yields "Display all 15 gazillion possibilites?")
shopt -s no_empty_cmd_completion
# Do not overwrite files when redirecting using ">". Note that you can still override this with ">|"
# set -o noclobber

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
# for option in autocd globstar; do
#   shopt -s "$option" 2> /dev/null
# done

# Locale
export LC_ALL=en_US.UTF-8
export LANG="en_US"

# no more less history
export LESSHISTFILE=-

# Prepend $PATH without duplicates
function _prepend_path() {
  if ! echo "$PATH" | tr ":" "\\n" | grep -qx "$1"; then
    PATH="$1:$PATH"
  fi
}

alias eb='vim ~/.bashrc'
alias ev='vim ~/.vimrc'
# Colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
NOCOLOR="$(tput sgr0)"

export RED
export GREEN
export YELLOW
export BLUE
export MAGENTA
export CYAN
export WHITE
export GRAY
export BOLD
export UNDERLINE
export INVERT
export NOCOLOR

export EDITOR='vim'
# Tell ls to be colourful
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# User color
case $(id -u) in
0) user_color="$RED" ;; # root
*) user_color="$GREEN" ;;
esac

# Symbols
prompt_symbol="❯"
prompt_clean_symbol="☀"
prompt_dirty_symbol="☂"
prompt_venv_symbol="☁"
# export PS1="\h\w:$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$ "
# alias k=kubectl
# source <(kubectl completion bash)
# complete -o default -o nospace -F __start_kubectl k

# alias d=docker
# _completion_loader docker
# complete -F _docker d

# alias h=helm
# source <(helm completion bash)
# complete -o default -o nospace -F __start_helm h

# alias k=kubectl
# _completion_loader kubectl
# complete -o default -o nospace -F __start_kubectl k

complete -o bashdefault -o default -o nospace -F _git g

# NVM initialisation
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvmexport PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(zoxide init bash)"

eval "$(starship init bash)"

source /Users/schuylermaclay/.config/broot/launcher/bash/br

source /Users/smaclay/.config/broot/launcher/bash/br
