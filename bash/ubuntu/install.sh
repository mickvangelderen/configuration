#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export MICK_CONFIGURATION_FOLDER="$(dirname $(dirname $SCRIPT_DIRECTORY))"

if grep -q MICK_CONFIGURATION_FOLDER ~/.bashrc; then
	echo ".bashrc seems to already have been modified."
else
	printf '
export MICK_CONFIGURATION_FOLDER="%s"
export PATH="$PATH\
:$MICK_CONFIGURATION_FOLDER/bin\
:$MICK_CONFIGURATION_FOLDER/bin/linux"
. "$MICK_CONFIGURATION_FOLDER/bash/index.sh"
' "$MICK_CONFIGURATION_FOLDER" >> ~/.bashrc
	echo "<<< .bashrc <<<"
	cat ~/.bashrc
	echo ">>> .bashrc >>>"
fi
