# *** Common ***
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias d='dirs -v | head -10'
alias c='clear'
alias e='$EDITOR'
alias h='history'

if [[ "$(uname)" == "Darwin" ]]; then
    alias ls='ls -G'
    alias ll='ls -G -i -lF'
else
    alias ls='ls --color=auto'
    alias ll='ls -i -lF --color=auto'
fi

alias la='ls -i'
alias lla='ls -la -i'
alias lt='ls -lha /tmp'
alias pingg='ping -c 3 www.google.com'
alias ping6='ping -6'
alias ping8='ping -c 3 8.8.8.8'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure  '
alias xtime='date +%T'
alias myip='curl ifconfig.me'
alias nopaste="nc termbin.com 9999"
alias t="todo.sh"
alias k9='kill -9'
alias vp="vim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias gvp="gvim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias hg='history 0 | grep'
alias css='cscope -bqR'
alias w1='watch -n1 '
alias s='sudo'
alias k='kubectl'
alias newpwd="tr -dc '[:print:]' < /dev/urandom | head -c 32 | base64"

# *** Linux-only aliases ***
if [[ "$(uname)" != "Darwin" ]]; then
    alias ip='ip -c'
    alias i3lock='i3lock -c 000000 -n'
    alias cysnc='sudo chronyc waitsync'
    alias netctl-current='netctl list | grep "*"'
    alias st='st -e /bin/zsh'
    alias windows='xfreerdp +clipboard /u:francesco /v:192.168.122.56 /size:1920x1040 /drive:linuz,$HOME/Downloads'
    alias jc='journalctl'
    alias ipr='ip r'
    alias sysu="systemctl --user"
fi

#if type nvim > /dev/null 2>&1; then
#  alias vim='nvim'
#  alias gvim= 'nvim-qt'
#  alias vimdiff= 'nvim -d'
#fi

# *** SUDO / PACKAGE MANAGER ***
if [[ "$(uname)" == "Darwin" ]]; then
    alias pc='brew'
else
    if [ $UID -eq 0 ]; then
        alias mount='mount |column -t'
        alias umount='umount '
        alias netctl='netctl '
        alias pc='pacman '
        alias docker='docker '
    else
        alias mount='sudo mount | column -t'
        alias umount='sudo umount '
        alias netctl='sudo netctl '
        alias pc='sudo pacman '
        alias docker='sudo docker '
        alias sd='sudo docker '
    fi
fi

#  *** GIT  ***
alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbr='git branch --remote'

alias gbis='git bisect'

alias gc='git commit -S -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'

alias gl='git log --oneline --decorate'
alias glo="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

alias gco='git checkout '

alias gcl='git clone --recursive'

alias gd='git diff'

alias gf='git fetch'
alias gfa='git fetch --all '
alias gfo='git fetch origin'

alias gp='git push '

alias gsb='git status -sb'
alias gs='git status -s'
alias gr='git review'
alias grd='git review -d'
