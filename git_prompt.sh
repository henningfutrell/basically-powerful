# Get super awesome stuff these peeps did
source "$z_core/zsh-git-prompt/zshrc.sh"

# Set a custom status prompt
git_status() {
    if [ -n "$__CURRENT_GIT_STATUS" ]; then
        # symbols
        # ● ✖ ✚ ✔  …

        # Prefixes, colors, suffixes
        local BRANCH_PREFIX=" on "
        local BRANCH_SUFFIX=""
        local CHANGES_PREFIX=""
        local CHANGES_SUFFIX=""
        local PROMPT_SEPARATOR=" "
        local C_BRANCH_UNCHANGED="%{$fg_bold[green]%}"
        local C_BRANCH_CHANGED="%{$fg_bold[red]%}"
        local C_STAGED=" %{$fg[green]%}●"
        local C_CHANGED=" %{$fg[yellow]%}●"
        local C_UNTRACKED=" %{$fg[cyan]%}●"
        local C_CONFLICTS=" %{$fg[red]%}✖"
        local C_BEHIND=" ↓"
        local C_AHEAD=" ↑"

        # Prompt combinators
        local branch_prompt="$BRANCH_PREFIX"
        local changes_prompt=""

        # If no changes, prompt should be green and carry on. Else, show changes in status
        # and change branch name color to indicate.
        if [ "$GIT_CHANGED" -eq "0" ] && [ "$GIT_CONFLICTS" -eq "0" ] && [ "$GIT_STAGED" -eq "0" ] && [ "$GIT_UNTRACKED" -eq "0" ]; then
            branch_prompt="$branch_prompt$C_BRANCH_UNCHANGED"
        else
            branch_prompt="$branch_prompt$C_BRANCH_CHANGED"
            changes_prompt="$changes_prompt$CHANGES_PREFIX"
            if [ "$GIT_STAGED" -ne "0" ]; then
                changes_prompt="$changes_prompt$C_STAGED$GIT_STAGED$rc"
            fi
            if [ "$GIT_CHANGED" -ne "0" ]; then
                changes_prompt="$changes_prompt$C_CHANGED$GIT_CHANGED$rc"
            fi
            if [ "$GIT_UNTRACKED" -ne "0" ]; then
                changes_prompt="$changes_prompt$C_UNTRACKED$GIT_UNTRACKED$rc"
            fi
            if [ "$GIT_CONFLICTS" -ne "0" ]; then
                changes_prompt="$changes_prompt$C_CONFLICTS$GIT_CONFLICTS$rc"
            fi
            changes_prompt="$changes_prompt$CHANGES_SUFFIX"
        fi

        branch_prompt="$branch_prompt$GIT_BRANCH$rc"
        if [ "$GIT_BEHIND" -ne "0" ]; then
            branch_prompt="$branch_prompt$C_BEHIND$GIT_BEHIND$rc"
        fi
        if [ "$GIT_AHEAD" -ne "0" ]; then
            branch_prompt="$branch_prompt$C_AHEAD$GIT_AHEAD$rc"
        fi
        branch_prompt="$branch_prompt$BRANCH_SUFFIX"

        echo "$branch_prompt$changes_prompt$parse_git_dirty"
    fi
}
