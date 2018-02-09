setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

# *** Common ***
alias ..='cd ../'
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
alias vimtest='vim -u ~/.vimrctest'
alias gvimtest='gvim -u ~/.vimrctest'
alias gvim='gvim -geometry 55x39'
alias pingg='ping -c 3 www.google.com'
alias ping8='ping -c 3 8.8.8.8'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure  '
alias i3lock='i3lock -c 000000 -n'
alias xtime='date +%T'
alias mountt='sudo mount -t ntfs-3g $1 $2'
#alias ntpsync='ntpdate -q 0.rhel.pool.ntp.org'
alias cysnc='sudo chronyc waitsync'
alias myip='curl ifconfig.me'
alias netctl-current='netctl list | grep "*"'
alias nopaste="curl -F 'sprunge=<-' http://sprunge.us"
alias st='st -e /bin/zsh'
alias windows='xfreerdp +clipboard /u:francesco /p:francesco /v:192.168.122.185 /size:1920x1  040'
alias jekylldraft='jekyll server --watch --drafts'
alias k9='kill -9'
alias vp="vim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias gvp="gvim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias jc='journalctl'
alias hg='history 0 | grep'
alias css='cscope -bqR'
alias w1='watch -n1 '
alias wtf='dmesg'
alias s='sudo'
alias ipr='ip r'

# *** Spotify ***
alias spn="~/script/sp next"
alias spp="~/script/sp prev"
alias sps="~/script/sp play"
alias spc="~/script/sp current"
alias sp="~/script/sp"


# *** SUDO ***
if [ $UID -eq 0 ]; then
	alias mount='mount |column -t'
	alias umount='umount '
	#alias systemctl='systemctl '
	alias netctl='netctl '
	alias pc='pacman '
	alias docker='docker '
else
	alias mount='sudo mount | column -t'
	alias umount='sudo umount '
	#alias systemctl=' systemctl '
	alias netctl='sudo netctl '
	alias pc='sudo pacman '
	alias docker='sudo docker '
fi

#  *** GIT  ***
alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbr='git branch --remote'

alias gbis='git bisect'

alias gc='git commit -v'
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

# *** TEST on PTPB ***

alias nopastept="curl -F c=@- https://ptpb.pw/"
