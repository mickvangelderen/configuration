#!/usr/bin/env bash

source /usr/share/git/completion/git-prompt.sh

function setPrompt {
	local BLACK='\[\e[0;30m\]'
	local BLACKBOLD='\[\e[1;30m\]'
	local RED='\[\e[0;31m\]'
	local REDBOLD='\[\e[1;31m\]'
	local GREEN='\[\e[0;32m\]'
	local GREENBOLD='\[\e[1;32m\]'
	local YELLOW='\[\e[0;33m\]'
	local YELLOWBOLD='\[\e[1;33m\]'
	local BLUE='\[\e[0;34m\]'
	local BLUEBOLD='\[\e[1;34m\]'
	local PURPLE='\[\e[0;35m\]'
	local PURPLEBOLD='\[\e[1;35m\]'
	local CYAN='\[\e[0;36m\]'
	local CYANBOLD='\[\e[1;36m\]'
	local WHITE='\[\e[0;37m\]'
	local WHITEBOLD='\[\e[1;37m\]'
	local ENDCOLOR='\[\e[00m\]'
	local DATE="$PURPLEBOLD\D{%Y-%b-%d %H:%M:%S}$ENDCOLOR"

	local ME="$GREENBOLD\u$ENDCOLOR"
	local HOST="$GREENBOLD\h$ENDCOLOR"
	local LOCATION="$BLUEBOLD\w$ENDCOLOR"

	# If the __git_ps1 command is available, add it to the prompt
	local GIT=""
	if [[ "$(type -t __git_ps1)" -eq "function" ]]; then
		GIT="$YELLOWBOLD\`__git_ps1\`$ENDCOLOR"
	fi

	local S=$'\u2500\u2500'
	local RAINBOW="\
$RED$S$REDBOLD$S\
$GREEN$S$GREENBOLD$S\
$YELLOW$S$YELLOWBOLD$S\
$BLUE$S$BLUEBOLD$S\
$PURPLE$S$PURPLEBOLD$S\
$CYAN$S$CYANBOLD$S"

	export PS1="$RAINBOW\\n$DATE $LOCATION$GIT\\n$ME@$HOST "
}

setPrompt
