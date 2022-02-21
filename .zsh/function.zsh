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

ssh() {
  if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm= | cut -d : -f1)" = "tmux" ]; then
    tmux rename-window "$(echo -- $* | awk '{print $NF}')"
    command ssh "$@"
    tmux set-window-option automatic-rename "on" 1>/dev/null
  else
    command ssh "$@"
  fi
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

aping() {
    if ! ping -c1 -w 5 "$1" &>/dev/null; then echo "Host is down"; else echo "isalive"; fi
}

_clone_and_fetch_PS() {
    git clone "$1" "$2"
    cd "$2"
    git review -d "$2"
    git checkout -b "$2"
}

git-clone-review() {
    BASE_URL="https://review.opendev.org/openstack"
    project="$1"
    review="$2"

    [ -d "$project" ] && rm -rf "$project"

    TARGET="$BASE_URL/$project"
    if [ -n "$review" ]; then
        _clone_and_fetch_PS "$TARGET" "$review"
    else
        git clone "$TARGET"
        cd "$1"
    fi

}

n(){
    local running_servers=$(nvr --serverlist)
    local n_server_name=/tmp/nvr_nvim-qt
    # if [ nvr -s --nostart --servername /tmp/nvr_nvim-qt  --remote-expr "'OK'" ]; then
    if [[ -z "$running_servers" || -z $1 || $running_servers != *"$n_server_name"* ]]; then
        NVIM_LISTEN_ADDRESS=$n_server_name nvim-qt $@
    elif [[ $running_servers == *"$n_server_name"* ]]; then
        local running_client=$(ps -fC nvim-qt | awk 'NR>1{print $8}')
        if [[ $running_client == *"nvim-qt"* ]]; then
            nvr --servername $n_server_name --remote-tab $@
        else
            \rm $n_server_name
            NVIM_LISTEN_ADDRESS=$n_server_name nvim-qt $@
        fi
    fi
}
