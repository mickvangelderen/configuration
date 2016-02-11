#!/usr/bin/env bash

if grep -q MICK_CONFIGURATION_FOLDER ~/.bashrc; then
	echo ".bashrc seems to already have been modified."
else
	printf '%s' '
export MICK_CONFIGURATION_FOLDER="$HOME/projects/configuration"
export PATH="$PATH:$MICK_CONFIGURATION_FOLDER/bin"
export PATH="$PATH:$MICK_CONFIGURATION_FOLDER/bin/linux"
. "$MICK_CONFIGURATION_FOLDER/bash/index.sh"
' >> ~/.bashrc
	echo "<<< .bashrc <<<"
	cat ~/.bashrc
	echo ">>> .bashrc >>>"
fi

export MICK_CONFIGURATION_FOLDER="$HOME/projects/configuration"
