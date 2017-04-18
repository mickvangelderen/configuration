#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"

git config --global core.excludesfile "$SCRIPT_DIRECTORY/.gitignore"
git config --global user.name "Mick van Gelderen"
git config --global user.email "mickvangelderen@gmail.com"
git config --global core.editor "vim"

mkdir --parents "$HOME/bin"
ln --symbolic --relative "$SCRIPT_DIRECTORY/git-unpushed.bash" "$HOME/bin/git-unpushed"
