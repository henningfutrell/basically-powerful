# Get local path
if [[ `uname` == 'Darwin' ]]; then
    z_core="$(dirname "$(readlink ~/.zshrc)")"
else
    z_core="$(dirname "$(readlink -f ~/.zshrc)")"
fi

# SSH Keys to add to user agent
# To not add keys set SSH_ADD_KEYS=0
SSH_ADD_KEYS=1
SSH_KEY_DIR=~/.ssh
SSH_KEYS=(id_github)

source "$z_core/builder.sh"
