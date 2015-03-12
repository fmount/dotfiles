if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
    ssh-add  ~/.ssh/github_rsa
    #ssh-add
fi
[[ -f ~/.zshrc ]] && . ~/.zshrc
