function get_git_info {
  # The returned git info is predecated on git managing changes. This is a
  # useful distinction when it comes to adding a change and modifying the file.
  # In VSCode this is marked as a modified file, which is true, but git will
  # commit a change to the file. For this reason git info will report a file to
  # be staged AND changed, because we are considering the changes and not just
  # the file.

  # Preloads git git_status -s. This will only be evaluated once. The git_status string
  # must be quoted to preserve new lines.
  local git_status=$(git status -s)

  # { "A " => newly added, "M " => modified } and staged
  local staged=$(egrep "^(A.|M.)" <<< "$git_status" | wc -l | tr -d "[:space:]")

  # "AM|MM" => addendum changes to staged file are unstaged
  local changed=$(egrep "^.M" <<< "$git_status" | wc -l | tr -d "[:space:]")

  # "??" => wholly untracked
  local untracked=$(egrep "^\?\?" <<< "$git_status" | wc -l | tr -d "[:space:]")

  # { "AA" => (add/add), "UU" => unmerged paths } conflict 
  local conflicted=$(egrep "^(AA|UU)" <<< "$git_status" | wc -l | tr -d "[:space:]")

  # Can be parsed with awk 'BEGIN {OFS=" ";}; {printf "%s", $n}' where $n is $1,
  # $2...related to order in this string.
  echo "$staged $changed $untracked $conflicted"
}

git_status() {
    if git rev-parse --git-dir > /dev/null 2>&1  ||  git rev-parse --is-inside-working-tree 2> /dev/null ; then
        local git_status=$(get_git_info)
        local staged=$(awk 'BEGIN {OFS=" ";}; {printf "%s", $1}' <<< $git_status)
        local changed=$(awk 'BEGIN {OFS=" ";}; {printf "%s", $2}' <<< $git_status)
        local untracked=$(awk 'BEGIN {OFS=" ";}; {printf "%s", $3}' <<< $git_status)
        local conflicted=$(awk 'BEGIN {OFS=" ";}; {printf "%s", $4}' <<< $git_status)
        local branch=$(git rev-parse --abbrev-ref HEAD)

        if [ "$git_status" != "0 0 0 0" ]; then
            # symbols
            # ● ✖ ✚ ✔  …

            # Prefixes, colors, suffixes
            local c_branch_clean="%{$fg_bold[green]%}"
            local c_branch_dirty="%{$fg_bold[red]%}"
            local c_staged=" %{$fg[green]%}●"
            local c_changed=" %{$fg[yellow]%}●"
            local c_untracked=" %{$fg[cyan]%}●"
            local c_conflicts=" %{$fg[red]%}✖"
            local c_behind=" ↓"
            local c_ahead=" ↑"

            # Prompt combinators
            local branch_prompt=' '
            local changes_prompt=' ' 

            # If no changes, prompt should be green and carry on. Else, show changes in git_status
            # and change branch name color to indicate.
            if [ "$changed" -eq "0" ] && [ "$conflicts" -eq "0" ] && [ "$staged" -eq "0" ] && [ "$untracked" -eq "0" ]; then
                branch_prompt="$branch_prompt$c_branch_clean"
            else
                branch_prompt="$branch_prompt$c_branch_dirty"
                changes_prompt="$changes_prompt"
                if [ "$staged" -ne "0" ]; then
                    changes_prompt="$changes_prompt$c_staged$staged$rc"
                fi
                if [ "$changed" -ne "0" ]; then
                    changes_prompt="$changes_prompt$c_changed$changed$rc"
                fi
                if [ "$untracked" -ne "0" ]; then
                    changes_prompt="$changes_prompt$c_untracked$untracked$rc"
                fi
                if [ "$conflicted" -ne "0" ]; then
                    changes_prompt="$changes_prompt$c_conflicts$conflicts$rc"
                fi
                changes_prompt="$changes_prompt$CHANGES_SUFFIX"
            fi

            branch_prompt="$branch_prompt$branch$rc"
           # if [ "$GIT_BEHIND" -ne "0" ]; then
           #     branch_prompt="$branch_prompt$C_BEHIND$GIT_BEHIND$rc"
           # fi
           # if [ "$GIT_AHEAD" -ne "0" ]; then
           #     branch_prompt="$branch_prompt$C_AHEAD$GIT_AHEAD$rc"
           # fi
           # branch_prompt="$branch_prompt$BRANCH_SUFFIX"

            echo "$branch_prompt$changes_prompt"
        fi
    fi
}
