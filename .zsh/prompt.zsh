setopt prompt_subst

autoload -Uz add-zsh-hook vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-changes false
zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}*%f'
zstyle ':vcs_info:git:*' formats '(%F{81}%b%f)[%c%u%m]'
zstyle ':vcs_info:git:*' actionformats '(%F{81}%b%f|%F{yellow}%a%f)[%c%u%m]'
zstyle ':vcs_info:git*+set-message:*' hooks git-status

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=grey'

# Gather all extra Git state once per prompt. The porcelain XY columns cover
# staged, unstaged, untracked, deleted, renamed, and conflicted files.
function +vi-git-status() {
    local line x y porcelain branch oid ahead_field behind_field
    local behind=0 ahead=0 commits=0
    local staged=false unstaged=false

    porcelain=$(command git status --porcelain=v2 --branch --untracked-files=normal 2>/dev/null)
    while IFS= read -r line; do
        [[ -z $line ]] && continue
        case $line in
            '# branch.oid '*)
                oid=${line#\# branch.oid }
                ;;
            '# branch.head '*)
                branch=${line#\# branch.head }
                ;;
            '# branch.ab '*)
                read -r ahead_field behind_field <<< "${line#\# branch.ab }"
                ahead=${ahead_field#+}
                behind=${behind_field#-}
                ;;
            [12u]' '*)
                x=${line[3]}
                y=${line[4]}
                [[ $x != '.' ]] && staged=true
                [[ $y != '.' ]] && unstaged=true
                ;;
            '? '*)
                unstaged=true
                ;;
        esac
    done <<< "$porcelain"

    if [[ $branch == '(detached)' ]]; then
        branch=${oid[1,7]}
    fi
    [[ -n $branch ]] && hook_com[branch]=$branch

    $staged && hook_com[staged]='%F{green}+%f'
    $unstaged && hook_com[unstaged]='%F{yellow}*%f'

    if (( behind && ahead )); then
        hook_com[misc]+='%F{166}↕%f'
    elif (( behind )); then
        hook_com[misc]+='%F{166}↓%f'
    elif (( ahead )); then
        hook_com[misc]+='%F{166}↑%f'
    fi

    commits=$(command git rev-list --count HEAD 2>/dev/null) || commits=0
    if [[ -n ${hook_com[staged]} || -n ${hook_com[unstaged]} || -n ${hook_com[misc]} ]]; then
        hook_com[misc]+=' '
    fi
    hook_com[misc]+="C:${commits}"
}

function _update_vcs_info() {
    vcs_info
}
add-zsh-hook precmd _update_vcs_info

PROMPT=$'\n${VIMPROMPT}(%F{yellow}%?%f) %F{green}%~%f${vcs_info_msg_0_}%F{red}\n> %F{grey}% '

# Use a compact prompt over SSH.
[[ -n $SSH_CONNECTION ]] && PROMPT=' %F{242}%n@%m%f > '
