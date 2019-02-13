function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%}%n@)%m %{$FG[214]%}%(!.%1~.%~) $(git_prompt_info)%_$%{$reset_color%}%(?,%{%F{green}%},%{%F{red}%}) %{$reset_color%}%{%F{15}%}'

RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
