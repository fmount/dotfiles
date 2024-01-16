setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# *** Common ***
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias -- -='cd -'
alias d='dirs -v | head -10'
alias c='clear'
alias h='history'
alias ls='ls --color=auto'
alias ll='ls -i -lF --color=auto'
alias la='ls -i'
alias lla='ls -la -i'
alias lt='ls -lha /tmp'
alias ip='ip -c'
#alias vimtest='vim -u ~/.vimrctest'
#alias gvimtest='gvim -u ~/.vimrctest'
alias gvim='gvim -geometry 55x39'
alias pingg='ping -c 3 www.google.com'
alias ping6='ping -6'
alias ping8='ping -c 3 8.8.8.8'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure  '
alias i3lock='i3lock -c 000000 -n'
alias xtime='date +%T'
alias mountt='sudo mount -t ntfs-3g $1 $2'
alias cysnc='sudo chronyc waitsync'
alias myip='curl ifconfig.me'
alias netctl-current='netctl list | grep "*"'
alias nopaste="curl -F 'f:1=<-' ix.io"
alias t="todo.sh"
alias st='st -e /bin/zsh'
alias windows='xfreerdp +clipboard /u:francesco /v:192.168.122.56 /size:1920x1040 /drive:linuz,/home/fmount/Downloads'
alias jekylldraft='jekyll server --watch --drafts'
alias k9='kill -9'
alias vp="vim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias gvp="gvim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias jc='journalctl'
alias hg='history 0 | grep'
alias css='cscope -bqR'
alias w1='watch -n1 '
alias s='sudo'
alias ipr='ip r'
alias k='kubectl'
alias newpsw='tr -cd "[:graph:][:alpha:]" < /dev/urandom | head -c 43'
alias sysu="systemctl --user"
#alias head="sed 11q"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias gvim= 'nvim-qt'
  alias vimdiff= 'nvim -d'
fi

# *** SUDO ***
if [ $UID -eq 0 ]; then
    alias mount='mount |column -t'
    alias umount='umount '
    alias netctl='netctl '
    alias pc='pacman '
    alias docker='docker '
    alias vim='nvim '
    alias vimdiff= 'nvim -d'
else
    alias mount='sudo mount | column -t'
    alias umount='sudo umount '
    alias netctl='sudo netctl '
    alias pc='sudo pacman '
    alias docker='sudo docker '
    alias sd='sudo docker '
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
