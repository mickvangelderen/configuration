#!/usr/bin/env bash

git config --global user.name "Mick van Gelderen"
git config --global user.email "mickvangelderen@gmail.com"

git config --global core.editor "vim"

git config --global init.defaultBranch "master"

git config --global alias.p "push"
git config --global alias.pf "push --force-with-lease"
git config --global alias.po "!git push --set-upstream origin \"\$(git branch --show-current)\""
git config --global alias.ca "commit --amend --reuse-message --no-edit"
git config --global alias.cae "commit --amend --reuse-message"
git config --global alias.rom "!git fetch && git ls-remote --exit-code --heads origin master >/dev/null 2>&1 && git rebase --interactive origin/master || git rebase --interactive origin/main"
git config --global alias.rum "!git fetch && git ls-remote --exit-code --heads upstream master >/dev/null 2>&1 && git rebase --interactive upstream/master || git rebase --interactive upstream/main"
