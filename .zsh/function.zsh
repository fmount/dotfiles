# vim: ft=zsh
# # *** FUNCTIONS ***
#
#
#

_set_tmux_prefix() {
    if [[ -z $(ss | grep -i ssh) ]] then
        # No SSH sessions should be active
        tmux set-option -g prefix Escape
    else
        # SSH session is there, we want
        # backtick as prefix to avoid
        # overlapping w/ (N)VIM escape
        tmux set-option -g prefix '`'
    fi
}

_settitle() {
    printf "\033k$1\033\\"
}

ssh() {
    _settitle "${@: -1}"
    command ssh "$@"
    _settitle "zsh"
}

# Old LaTeX Building
texbuild(){
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
    fi
}

# pass function to select the specified ring
swapring(){

    if [[ -z "$1" ]]; then
        echo "Usage: swapring /path/to/ring"
    else
        export PASSWORD_STORE_DIR=$1
        export PASSWORD_STORE_GIT=$1
    fi

}

function aping {
    if [[ -z "$1" ]]; then
        echo "Usage: aping <host>"
    elif ! ping -c1 -w 5 "$1" &>/dev/null; then
	echo "Host is down"; else echo "isalive";
    fi
}

