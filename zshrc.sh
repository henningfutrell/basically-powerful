# Get local path
if [[ `uname` == 'Darwin' ]]; then
    z_core="$(dirname "$(readlink ~/.zshrc)")"
else
    z_core="$(dirname "$(readlink -f ~/.zshrc)")"
fi

source "$z_core/builder.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
