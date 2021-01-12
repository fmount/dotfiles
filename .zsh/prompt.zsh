NEWLINE=$'\n'
PR_RST="%f"

PLEN=8

#source ~/.zsh/symbols.zsh
setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color pallete if available
if [[ $terminfo[colors] -ge 256 ]]; then
  turquoise="%F{81}"
  orange="%F{166}"
  purple="%F{135}"
  hotpink="%F{161}"
  limegreen="%F{118}"
  heavenly="%F{81}"
  reset="%F{grey}"
else
  turquoise="%F{cyan}"
  orange="%F{yellow}"
  purple="%F{magenta}"
  hotpink="%F{red}"
  limegreen="%F{green}"
  heavenly="%F{81}"
  reset="%F{grey}"
fi

autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true

# hash changes branch misc
zstyle ':vcs_info:*+*:*' debug false
zstyle ':vcs_info:git:*' formats '(%F{81}%b%F{grey})[%u%m]'
#zstyle ':vcs_info:git:*' actionformats '(%F{81}%b%F{grey})[%c]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-count


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=%F{grey}'

# is_dirty
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -E '(??|M)' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[unstaged]="%{$fg_no_bold[yellow]%}*%{$reset_color%}|"
    fi
}


# is_ahead or behind
+vi-git-st() {
    local gitstatus

    remote_branch="$(command git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)"
    if [ -n "$remote_branch" ]; then
        ah0="$(command git rev-list --count --left-right $remote_branch...$prompt_local_branch | awk '{print $1}')"
        ah1="$(command git rev-list --count --left-right $remote_branch...$prompt_local_branch | awk '{print $2}')"
        [ ${ah0} -ne 0 ] && gitstatus+="${orange}$GIT_PULL_ARROW${reset}${cyan}$ah0${reset}|"
        [ ${ah1} -ne 0 ] && gitstatus+="${orange}$GIT_PUSH_ARROW${reset}${cyan}$ah1${reset}|"
    fi
    hook_com[misc]+=${gitstatus}
}

# Show count of stashed changes
function +vi-git-stash() {
    local -a stashes

    if [[ -s ${hook_com[base]}/.git/refs/stash ]] ; then
        stashes=$(git stash list 2>/dev/null | wc -l)
        hook_com[misc]+=" (${stashes} stashed)"
    fi
}


# Show commit count for the current branch
function +vi-git-count() {
    count="$(git rev-list --count HEAD 2>/dev/null)"
    [ -z "$count" ] && count=0
    hook_com[misc]+="C:$count"
}

check_path() {
    path=$(pwd)
    IFS='/' read -A mypath <<< "$path"
    if [ "${#mypath[@]}" -gt "$PLEN" ]; then
        if [ "${mypath[2]}" != 'home' ]; then
            printf "\[..] %s/%s" "$mypath[-2]" "$mypath[-1]"
        else
            printf "\%s %s/%s" "$ZSH_SYMBOL_HOME" "$mypath[-2]" "$mypath[-1]"
        fi
    else
        printf "%s" "~"
    fi
}


PROMPT=$'
${VIMPROMPT}(%F{yellow}%?%f) %{$limegreen%}%$(check_path)${PR_RST}${vcs_info_msg_0_}%F{red}
> %F{grey}%{$reset_color%}% '

#RPROMPT='[%F{yellow}%?%f]'

# show username@host if logged in through SSH
[[ "$SSH_CONNECTION" != '' ]] && PROMPT=' %F{242}%n@%m%f > '
