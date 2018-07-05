if [[ `uname` == 'Darwin' ]]; then
    z_core="$(dirname "$(readlink ~/.zshrc)")"
else
    z_core="$(dirname "$(readlink -f ~/.zshrc)")"
fi

cd $z_core
git pull update master 1&> /dev/null
cd ~

source "$z_core/builder.sh"

unset z_core
