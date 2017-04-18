#!/usr/bin/env bash

find * -maxdepth 0 -type d -print0 | while read -d $'\0' dir; do (
	cd "$dir"
	if ! STATUS=`git status --porcelain 2>/dev/null`; then
		echo -e "$PWD Is not a git directory."
		continue
	fi
	if [ -n "$STATUS" ]; then
		echo -e "$PWD Has uncommitted changes."
	fi
	if ! CHERRY=`git cherry 2>&1`; then
		echo -e "$PWD Failed to run git cherry:\n$CHERRY"
		continue
	fi
	if [ -n "$CHERRY" ]; then
		echo -e "$PWD Has unpushed commits."
	fi
) done
