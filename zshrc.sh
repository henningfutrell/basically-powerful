# Get local path
if [[ `uname` == 'Darwin' ]]; then
    z_core="$(dirname "$(readlink ~/.zshrc)")"
else
    z_core="$(dirname "$(readlink -f ~/.zshrc)")"
fi


source "$z_core/builder.sh"
