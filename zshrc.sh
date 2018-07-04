if [[ `uname` == 'Darwin' ]]; then
    z_core="$(dirname "$(readlink ~/.zshrc)")"
else
    z_core="$(dirname "$(readlink -f ~/.zshrc)")"
fi
echo "Zsh configuration files sourced from $z_core..."

source "$z_core/builder.sh"

unset z_core
