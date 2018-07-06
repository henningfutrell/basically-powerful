export update_basically_powerful_zsh () {
    local current_dir=$PWD
    cd $z_core
    git pull origin master
    git submodule update --init --recursive
    cd $current_dir
    unset current_dir
}

