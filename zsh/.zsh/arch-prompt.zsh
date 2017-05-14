NEWLINE=$'\n'
PR_RST="%f"

source ~/.zsh/symbols.zsh

#TODO: Check git better
git=$(which git)

setopt prompt_subst

autoload -U add-zsh-hook
autoload -Uz vcs_info

#use extended color pallete if available
if [[ $terminfo[colors] -ge 256 ]]; then
  turquoise="%F{81}"
  orange="%F{166}"
  purple="%F{135}"
  hotpink="%F{161}"
  limegreen="%F{118}"
  heavenly="%F{81}"
  reset="%F{grey}"
else
  turquoise="%F{cyan}"
  orange="%F{yellow}"
  purple="%F{magenta}"
  hotpink="%F{red}"
  limegreen="%F{green}"
  heavenly="%F{81}"
  reset="%F{grey}"
fi


is_ahead(){
	remote_branch="$(command git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)"
	if [ -n "$remote_branch" ]; then
		ah0="$(command git rev-list --count --left-right $remote_branch...$prompt_local_branch | awk '{print $1}')"
		ah1="$(command git rev-list --count --left-right $remote_branch...$prompt_local_branch | awk '{print $2}')"
		[ ${ah0} -ne 0 ] && echo " ${orange}$GIT_PULL_ARROW${reset}${cyan}$ah0${reset}"
		[ ${ah1} -ne 0 ] && echo " ${orange}$GIT_PUSH_ARROW${reset}${cyan}$ah1${reset}"
	else
		echo "%F{yellow}$ERROR_FETCH_REMOTE_INFO%F{grey}"
  fi
}

is_dirty(){
	if [ -n "$(command git status --porcelain)" ]; then 
		echo "%F{yellow}$GIT_BRANCH_CHANGED_SYMBOL%F{grey})$(is_ahead)%F{grey}"
	else
		echo "%F{grey})$(is_ahead)%F{grey}"
	fi
	#remote_branch="$(command git rev-parse --abbrev-ref --symbolic-full-name @{u})"
	#[ -n "$(command git log $remote_branch...HEAD)" ] && echo "%F{yellow}$GIT_BRANCH_CHANGED_SYMBOL$(is_ahead)%F{grey}"
}

check_git(){
	belongs_to_repo=$(command git rev-parse --git-dir 2>/dev/null)
	if [ -d "$belongs_to_repo"  ]; then
		prompt_local_branch="$(command git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||')"
		echo "(${heavenly}$prompt_local_branch$(is_dirty)%F{grey}"
	else
		prompt_local_branch="$(command git rev-parse --git-dir > /dev/null 2>&1)"
	fi
}


# show username@host if logged in through SSH
[[ "$SSH_CONNECTION" != '' ]] && PROMPT=' %F{242}%n@%m%f'

if [ $? -ne 0 ]; then
PROMPT=$'
${heavenly}%n${PR_RST} at %{$orange%}%m${PR_RST} in %{$limegreen%}%~${PR_RST}$(check_git)
${heavenly}⮝ %F{grey} '
else
PROMPT=$'
${heavenly}%n${PR_RST} at %{$orange%}%m${PR_RST} in %{$limegreen%}%~${PR_RST}$(check_git)
${heavenly} %F{grey} '
fi
#RPROMPT='[%F{yellow}%?%f]'
