# vim: ft=zsh
# # *** FUNCTIONS ***
#

ssh() {
  local ssh_status

  if [[ -n $TMUX ]]; then
    tmux rename-window -- "${@[-1]}"
    command ssh "$@"
    ssh_status=$?
    tmux set-window-option automatic-rename on >/dev/null
    return $ssh_status
  fi

  command ssh "$@"
}

# Old LaTeX Building
texbuild(){
    if (( $# != 1 )) || [[ ! -f $1 ]]; then
        print -u2 'usage: texbuild FILE.tex'
        return 2
    fi

    local source_file=${1:A}
    local source_dir=${source_file:h}
    local filename=${source_file:t:r}

    (
        cd "$source_dir" || return
        latex "$filename" || return
        latex "$filename" || return
        echo "Making dvi.."
        dvips "$filename.dvi" || return
        echo "Making ps.."
        ps2pdf "$filename.ps" || return
        echo "Making pdf"
        rm -f -- "$filename.log" "$filename.ps" "$filename.dvi" \
            "$filename.out" "$filename.aux"
    )
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
    if [[ "$(uname)" == "Darwin" ]]; then
        if ! ping -c1 -t 5 "$1" &>/dev/null; then echo "Host is down"; else echo "isalive"; fi
    else
        if ! ping -c1 -w 5 "$1" &>/dev/null; then echo "Host is down"; else echo "isalive"; fi
    fi
}

_clone_and_fetch_PS() {
    local target=$1 review=$2

    git clone "$target" "$review" || return
    cd "$review" || return
    git review -d "$review" || return
    git checkout -b "$review"
}

git-clone-review() {
    local base_url="https://review.opendev.org/openstack"
    local project=$1 review=$2 target

    if [[ -z $project ]]; then
        print -u2 'usage: git-clone-review PROJECT [REVIEW]'
        return 2
    fi

    if [[ -e $project ]]; then
        print -u2 -- "git-clone-review: destination already exists: $project"
        return 1
    fi

    target="$base_url/$project"
    if [ -n "$review" ]; then
        _clone_and_fetch_PS "$target" "$review"
    else
        git clone "$target" || return
        cd "$project"
    fi

}

n(){
    #local running_servers=$(nvr --serverlist)
    local n_server_name=/tmp/nvim
    if [[ $(nvr -s --nostart --servername $n_server_name  --remote-expr "'OK'") == "OK" ]]; then
        nvr --servername "$n_server_name" "$@"
    else
        NVIM_LISTEN_ADDRESS=$n_server_name nvim-qt "$@"
    fi
}

nsstat() {
    if [[ "$(uname)" == "Darwin" ]]; then
        lsof -iTCP -sTCP:LISTEN -P -n
    else
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
    fi
}


jekyll() {
    if (( $# == 0 )) then
        print -u2 'usage: jekyll BLOG_PATH'
        return 2
    fi
    podman run --rm -it \
      -v "$1:/srv/jekyll:Z" \
      -e JEKYLL_ROOTLESS=1 \
      -e BUNDLE_PATH='/srv/.bundle' \
      -p 4000:4000 \
      jekyll/jekyll bash -c "bundle update && jekyll serve --watch --drafts --future"

}
