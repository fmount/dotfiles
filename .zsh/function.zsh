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
    #local running_servers=$(nvr --serverlist)
    local n_server_name=/tmp/nvim
    if [[ $(nvr -s --nostart --servername $n_server_name  --remote-expr "'OK'") == "OK" ]]; then
        nvr --servername $n_server_name $@
    else
        NVIM_LISTEN_ADDRESS=$n_server_name nvim-qt $@
    fi
}

nsstat() {
    awk '
    function hextodec(str,ret,n,i,k,c){
        ret = 0
        n = length(str)
        for (i = 1; i <= n; i++) {
            c = tolower(substr(str, i, 1))
            k = index("123456789abcdef", c)
            ret = ret * 16 + k
        }
        return ret
    }
    function getIP(str,ret){
        ret=hextodec(substr(str,index(str,":")-2,2));
        for (i=5; i>0; i-=2) {
            ret = ret"."hextodec(substr(str,i,2))
        }
        ret = ret":"hextodec(substr(str,index(str,":")+1,4))
        return ret
    }
    $4 == "0A" { print getIP($2) }' /proc/net/tcp /proc/net/tcp6
}


jekyll() {
    if (( $# == 0 )) then
        echo usage: jekyll [blog-path] ...;
    fi
    podman run --rm --name blog_instance --volume="$1:/srv/jekyll" \
        -p 4000:4000 -it jekyll/jekyll:latest jekyll serve --watch --drafts
}
