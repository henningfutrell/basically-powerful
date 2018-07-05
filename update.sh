export update_basically_powerful_zsh () {
    cd $z_core
    git pull update master 1&> /dev/null
    git submodule update --init --recursive 1&> /dev/null
    cd ~
}

