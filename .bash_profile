#!/usr/bin/env bash
# shellcheck source=/Users/schuylermaclay/.bash_profile
[ -n "$PS1" ] && source ~/.bashrc;
export PATH="/usr/local/sbin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/schuylermaclay/google-cloud-sdk/path.bash.inc' ]; then . '/Users/schuylermaclay/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/schuylermaclay/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/schuylermaclay/google-cloud-sdk/completion.bash.inc'; fi

. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(/opt/homebrew/bin/brew shellenv)"

source /Users/schuylermaclay/.config/broot/launcher/bash/br

source /Users/smaclay/.config/broot/launcher/bash/br
