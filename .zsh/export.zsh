# Export all env variables in my laptop
# v.0.1alpha

# gpg pub key
#export GPG_KEY='1FCA0620'
#export GPG_SIGN_KEY='C66B3D3F'
export GPG_KEY='F41BD75C'
export GPG_SIGN_KEY='7301D458'

## ZSH EXPORT SETTINGS ##
export KEYTIMEOUT=20
export SSH_ASKPASS=''
export VISUAL="vim"
export EDITOR="vim"
#export BROWSER=w3m
export GOPATH=$HOME/golang-book
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin":$GOPATH/bin:$HOME/.cargo/bin
export GPG_TTY=$(tty)
export LC_COLLATE=en_US.UTF-8
export LANG=en_US.UTF-8
#export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' -c 'nm q <Esc>:q<CR>' - \""
export TERM=xterm-256color
#export SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
export PASSWORD_STORE_DIR=$HOME/.password-store_black

if [ -d "$HOME/.bookmarks" ]; then
    autoload -U bashcompinit
    bashcompinit
    export CDPATH=".:$HOME/.bookmarks:/"
    alias goto="cd -P"
    _goto() {
        local IFS=$'\n'
        COMPREPLY=($(compgen -W "$(/bin/ls ~/.bookmarks)" -- ${COMP_WORDS[COMP_CWORD]}))
    } && complete -F _goto goto
fi
