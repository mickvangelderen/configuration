#!/usr/bin/env bash

if [ ! -z "$PROMPT_COMMAND" ]; then
	PROMPT_COMMAND+='; '
fi
PROMPT_COMMAND+='printf %s "$PWD" > ~/restorable-working-directory.txt'
cd "$(<~/bash-last-dir.txt)"
