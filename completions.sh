# Completion

# Initialize completions for programs
autoload compinit && compinit

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==04=00}:${(s.:.)LS_COLORS}")'

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "%{$fg_bold[black]%}%B%d"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "%{$fg[red]%}No matches"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Highlight good commands
source "$z_core/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"