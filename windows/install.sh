#!/usr/bin/env bash

if grep -q '\-f \~\/\.bashrc' ~/.bash_profile; then
	echo ".bash_profile already seems to import .bashrc"
else
	printf '%s' '
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi
' >> ~/.bash_profile
	echo "<<< .bash_profile <<<"
	cat ~/.bash_profile
	echo ">>> .bash_profile >>>"
fi

if grep -q MICK_CONFIGURATION_FOLDER ~/.bashrc; then
	echo ".bashrc seems to already have been modified."
else
	printf '%s' '
export MICK_CONFIGURATION_FOLDER="$HOME/projects/configuration"
export PATH="$PATH:$MICK_CONFIGURATION_FOLDER/bin"
export PATH="$PATH:$MICK_CONFIGURATION_FOLDER/bin/windows"
. "$MICK_CONFIGURATION_FOLDER/bash/index.sh"
' >> ~/.bashrc
	echo "<<< .bashrc <<<"
	cat ~/.bashrc
	echo ">>> .bashrc >>>"
fi

export MICK_CONFIGURATION_FOLDER="$HOME/projects/configuration"
