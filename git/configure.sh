#!/usr/bin/env bash

git config --global user.name "Mick van Gelderen"
git config --global user.email "mickvangelderen@gmail.com"

git config --global core.editor "vim"

git config --global init.defaultBranch "master"

git config --global alias.pf "push --force-with-lease"
git config --global alias.po "!git push --set-upstream origin \"\$(git branch --show-current)\""
git config --global alias.ca "commit --amend --reuse-message"
git config --global alias.rom "!git fetch && git rebase --interactive origin/master"
