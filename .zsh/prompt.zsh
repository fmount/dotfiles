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
    local line x y porcelain branch
    local behind=0 ahead=0
    local staged=false unstaged=false

    branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) || \
        branch=$(command git rev-parse --short HEAD 2>/dev/null)
    [[ -n $branch ]] && hook_com[branch]=$branch

    porcelain=$(command git status --porcelain=v1 --untracked-files=normal 2>/dev/null)
    while IFS= read -r line; do
        [[ -z $line ]] && continue
        x=${line[1]}
        y=${line[2]}
        if [[ $x == '?' ]]; then
            unstaged=true
        else
            [[ $x != ' ' ]] && staged=true
            [[ $y != ' ' ]] && unstaged=true
        fi
    done <<< "$porcelain"

    $staged && hook_com[staged]='%F{green}+%f'
    $unstaged && hook_com[unstaged]='%F{yellow}*%f'

    if read -r behind ahead <<< "$(command git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)"; then
        if (( behind && ahead )); then
            hook_com[misc]+='%F{166}↕%f'
        elif (( behind )); then
            hook_com[misc]+='%F{166}↓%f'
        elif (( ahead )); then
            hook_com[misc]+='%F{166}↑%f'
        fi
    fi
}

function _update_vcs_info() {
    vcs_info
}
add-zsh-hook precmd _update_vcs_info

PROMPT=$'\n${VIMPROMPT}(%F{yellow}%?%f) %F{green}%~%f${vcs_info_msg_0_}%F{red}\n> %F{grey}% '

# Use a compact prompt over SSH.
[[ -n $SSH_CONNECTION ]] && PROMPT=' %F{242}%n@%m%f > '
