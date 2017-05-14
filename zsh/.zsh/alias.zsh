setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias docker='sudo docker'
alias ..='cd ../'
alias -- -='cd -'
alias d='dirs -v | head -10'
alias c='clear'
alias mount='mount |column -t'
alias h='history'
alias ls='ls --color=auto'
alias ll='ls -i -lF --color=auto'
alias la='ls -i'
alias lla='ls -la -i'
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
alias ntpsync='ntpdate -q 0.rhel.pool.ntp.org'
alias myip='curl ifconfig.me'
alias netctl-current='netctl list | grep "*"'
alias nopaste="curl -F 'sprunge=<-' http://sprunge.us"
alias st='st -e /bin/zsh'
alias windows='xfreerdp +clipboard /u:francesco /p:francesco /v:192.168.122.185 /size:1920x1  040'
eval $(thefuck --alias)
alias jekylldraft='jekyll server --watch --drafts'
alias k9='kill -9'
alias vp="vim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias gvp="gvim -c 'set nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' -c 'colorscheme jellybeans' - "
alias jc='journalctl'
alias hg='history 0 | grep'

# *** Spotify ***
alias spn="~/script/sp next"
alias spp="~/script/sp prev"
alias sps="~/script/sp play"
alias spc="~/script/sp current"
alias sp="~/script/sp"

# *** TEST on PTPB ***

alias nopastept="curl -F c=@- https://ptpb.pw/"



# *** TEST on ix ***
ix(){
   local opts
   local OPTIND
   [ -f "$HOME/.netrc" ] && opts='-n'
   while getopts ":hd:i:n:" x; do
      case $x in
        h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
        d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
        i) opts="$opts -X PUT"; local id="$OPTARG";;
        n) opts="$opts -F read:1=$OPTARG";;
       esac
   done
   shift $(($OPTIND - 1))
   [ -t 0 ] && {
   local filename="$1"
   shift
   [ "$filename" ] && {
   curl $opts -F f:1=@"$filename" $* ix.io/$id
   return
   }
   echo "^C to cancel, ^D to send."
   }
   curl $opts -F f:1='<-' $* ix.io/$id
}
