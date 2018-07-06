export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

if [[ `uname` == 'Linux' ]]; then
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi


