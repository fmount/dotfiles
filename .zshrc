
zstyle ":completion:*:commands" rehash 1
zstyle ':completion:::*:default' menu no select
zstyle ':completion:*' rehash true
#zstyle ':completion:*' hosts off
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -Uz compinit promptinit colors
compinit
promptinit
colors


#history options
setopt interactivecomments
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_history
setopt PROMPT_SUBST
#setopt inc_append_history
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000
HISTTIMEFORMAT='%F %T  '
unsetopt beep


source ~/.zsh/export.zsh
source ~/.zsh/alias.zsh
source ~/.zsh/arch-git-prompt.zsh
source ~/.zsh/function.zsh
source ~/.zsh/termsupport.zsh

DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi

chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME

## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS

## This reverts the +/- operators.
setopt PUSHD_MINUS

bindkey -v

# History Search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^R" history-incremental-search-backward
bindkey "^A" history-beginning-search-backward
bindkey "^B" history-beginning-search-forward

typeset -A key

# Searching autocompl using <Ctrl>j/k
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey -M vicmd '^k' up-line-or-beginning-search
bindkey -M vicmd '^j' down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# *** super esc vi style ***
bindkey 'jj' vi-cmd-mode

# *** Vim mode movements
bindkey -M vicmd 'H' vi-beginning-of-line
bindkey -M vicmd 'L' vi-end-of-line

# Fix vi mode search on zsh history session
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -v "^[[3~"   delete-char
bindkey -v "^[3;5~"  delete-char
# ** Fix backspace
bindkey -v '^?' backward-delete-char

# Home key variants
bindkey '\eOH' vi-beginning-of-line
bindkey -M vicmd '\eOH' vi-beginning-of-line

# End key variants
bindkey '\eOF' vi-end-of-line
bindkey -M vicmd '\eOF' vi-end-of-line

# Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.

function zle-line-init zle-keymap-select {
    #RPS1="${${KEYMAP/vicmd/[NOR]}/(main|viins)/[INS]}"
    #RPS2=$RPS1
	VIM_PROMPT="%{$fg_bold[yellow]%}[% NOR]% %{$reset_color%} "
	NOR_PROMPT="%{$fg_bold[grey]%}[% INS]% %{$reset_color%} "
	VIMPROMPT="${${KEYMAP/vicmd/${VIM_PROMPT}}/(main|viins)/${NOR_PROMPT}}"
    zle reset-prompt
}


zle -N zle-line-init
zle -N zle-keymap-select


# *** Yank in the clipboard ***
x-yank() {
    zle copy-region-as-kill
    print -rn -- $CUTBUFFER | xclip -in -selection clipboard
}
zle -N x-yank

x-cut() {
    zle kill-region
    print -rn -- $CUTBUFFER | xclip -in -selection clipboard
}
zle -N x-cut

x-paste() {
    CUTBUFFER=$(xclip -selection clipboard -o)
    zle yank
}
zle -N x-paste


setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
### This reverts the +/- operators.
setopt pushdminus

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault

source /usr/bin/virtualenvwrapper.sh
