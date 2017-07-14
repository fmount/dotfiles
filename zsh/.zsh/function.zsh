# vim: ft=zsh
# # *** FUNCTIONS ***
#
#
#

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

# PASS EXPORT THE CORRENT RING ##

function swapring(){

        if [[ -z "$1" ]]; then
                echo "Usage: swapring /path/to/ring"
        else
                export PASSWORD_STORE_DIR=$1
    export PASSWORD_STORE_GIT=$1
        fi

}


