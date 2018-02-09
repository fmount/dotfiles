# vim: ft=zsh
# # *** FUNCTIONS ***
#
#
#

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
                #evince $filename.pdf
        fi
}

# PASS EXPORT THE CORRENT RING ##

swapring(){

        if [[ -z "$1" ]]; then
                echo "Usage: swapring /path/to/ring"
        else
                export PASSWORD_STORE_DIR=$1
    export PASSWORD_STORE_GIT=$1
        fi

}

function aping {
	if ! ping -c1 -w 5 "$1" &>/dev/null; then echo "Host is down"; else echo "isalive"; fi
}

#task list and summary
tl() {
	if [[ -z "$1" ]]; then
		task list && task summary
	else
		task list project:$1 && task summary project:$1
	fi
}

