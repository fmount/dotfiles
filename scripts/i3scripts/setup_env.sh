#!/bin/bash

declare -A KEYS
KEYS=([GITHUB]="$HOME/.ssh/gogs" [ANSIBLE]="$HOME/.ssh/id_rsa.ansible")

setup_env() {
	# Start ssh-agent
	eval "$(ssh-agent -s)"
	# load Xresources
	xrdb -all "$HOME"/.Xresources
	# and add the keys
	for key in "${KEYS[@]}"; do
		ssh-add "$key"
	done
}

setup_env
