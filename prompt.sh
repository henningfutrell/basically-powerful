#=====================================================
# Shell prompt

# Colors
#
autoload -U colors && colors
# Prompt color
pc="%{$fg[default]%}"
# Directory color
dc="%{$fg[yellow]%}"
# Reset color
rc="%{$reset_color%}"
# New line
nl=$'\n'

# Load in git prompt
source "$z_core/git_prompt.sh"

# Sybmols
# ╭─ ╰─ ➜
# Allows functions in the prompt
setopt PROMPT_SUBST

main_prompt="${nl}${pc}╭─%n@%m ${dc}%~${rc}"
entry_indicator="${pc}╰─ "

PROMPT='$main_prompt $(git_status)
$entry_indicator'
PS2='$pc.. '
PS3='$pc... '
