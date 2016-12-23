#
#
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


zstyle ":completion:*:commands" rehash 1
zstyle ':completion:::*:default' menu no select

autoload -Uz compinit promptinit colors
compinit
promptinit
colors
prompt steeef

#history options
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt extended_history
setopt inc_append_history
HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000

unsetopt beep

bindkey -v

# History Search
autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^R" history-incremental-search-backward
bindkey "^A" history-beginning-search-backward
bindkey "^B" history-beginning-search-forward

export KEYTIMEOUT=1


typeset -A key

# Searching autocompl using <Ctrl>j/k
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search

bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search
bindkey '^[[3~'	delete-char
bindkey '^[3;5~' delete-char

# Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/ [NORMAL]}/(main|viins)/[INSERT]}"
    RPS2=$RPS1
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

#DIRSTACK CONF
#DIRSTACKFILE="$HOME/.cache/zsh/dirs"
#if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
#	   dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
#	     [[ -d $dirstack[1] ]] && cd $dirstack[1]
#fi
#chpwd() {
#   print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
#}

#DIRSTACKSIZE=20
setopt autopushd pushdsilent pushdtohome
## Remove duplicate entries
setopt pushdignoredups
### This reverts the +/- operators.
setopt pushdminus


alias docker='sudo docker'
alias ..='cd ..'
alias c='clear'
alias mount='mount |column -t'
alias h='history'
alias ls='ls --color=auto'
alias ll='ls -i -lF --color=auto'
alias la='ls -i'
alias lla='ls -la -i'
alias vimtest='vim -u ~/.vimrctest'
alias gvimtest='gvim -u ~/.vimrctest'
alias gvim='gvim -geometry 55x39'
alias pingg='ping -c 3 www.google.com'
alias ping8='ping -c 3 8.8.8.8'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure'
alias i3lock='i3lock -c 000000 -n'
alias xtime='date +%T'
alias mountt='sudo mount -t ntfs-3g $1 $2'
alias ntpsync='ntpdate -q 0.rhel.pool.ntp.org'
alias myip='curl ifconfig.me'
alias netctl-current='netctl list | grep "*"'
alias nopaste="curl -F 'sprunge=<-' http://sprunge.us"
alias st='st -e /bin/zsh'
alias windows='xfreerdp +clipboard /u:francesco /p:francesco /v:192.168.122.185 /size:1920x1040'
eval $(thefuck --alias)
alias jekylldraft='jekyll server --watch --drafts'
alias k9='kill -9'
alias vp="vim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias gvp="gvim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias jc='journalctl'

# *** Spotify ***
alias spn="~/script/sp next"
alias spp="~/script/sp prev"
alias sps="~/script/sp play"
alias spc="~/script/sp current"
alias sp="~/script/sp"

# *** Settings Exported ***
export SSH_ASKPASS=''
export VISUAL="vim"
export EDITOR="vim"
export BROWSER=w3m
export GOPATH=$HOME/golang-book
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin":$GOPATH/bin
export GPG_TTY=$(tty)
export LC_COLLATE=en_US.UTF-8
export LANG=en_US.UTF-8
export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' - \""
export TERM=xterm-256color

#MY OLD BASHRC CONFIG FUNCTs
tl() {
	if [[ -z "$1" ]]; then
		task list && task summary
	else
		task list project:$1 && task summary project:$1
	fi
}


# Old LaTeX Building
function texbuild(){
	filename=$(basename "$1")
	extension="${filename##*.}"
	filename="${filename%.*}"
	if [ -f "$1" ]; then
		latex $filename
		latex $filename
		echo "Making dvi.."
		dvips $filename.dvi #-o $filename.ps
		echo "Making ps.."
		ps2pdf $filename.ps
		echo "Making pdf"
		rm *.log *.ps *.dvi *.out *.aux
		#evince $filename.pdf
	fi
}

function swapring(){
	if [[ -z "$1" ]]; then
		echo "Usage: swapring /path/to/ring"
	else
		export PASSWORD_STORE_DIR=$1
		export PASSWORD_STORE_GIT=$1
	fi
}
