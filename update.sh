export update_basically_powerful_zsh () {
    cd $z_core
    git pull update master
    git submodule update --init --recursive
    cd ~
}

