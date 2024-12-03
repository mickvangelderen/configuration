#!/usr/bin/env bash

git config --global user.name "Mick van Gelderen"
git config --global user.email "mickvangelderen@gmail.com"
git config --global core.editor "vim"
git config --global init.defaultBranch "main"

git config --global alias.default-branch '!sed -e '\''s/^.*\///'\'' < .git/refs/remotes/origin/HEAD'
git config --global alias.a 'add'
git config --global alias.p 'push'
git config --global alias.pf 'push --force-with-lease'
git config --global alias.po '!git push --set-upstream origin "$(git branch --show-current)"'
git config --global alias.c 'commit'
git config --global alias.wip 'commit -m WIP'
git config --global alias.awip 'commit -a -m WIP'
git config --global alias.ca 'commit --amend --no-edit'
git config --global alias.cae 'commit --amend'
git config --global alias.cf 'commit --fixup'
git config --global alias.r 'rebase --interactive --autosquash'
git config --global alias.new '!git fetch && git switch --create "$1" "origin/$(git default-branch)" #'
git config --global alias.rom '!git fetch && git rebase --interactive --autosquash "origin/$(git default-branch)"'
git config --global alias.rum '!git fetch && git rebase --interactive --autosquash "upstream/$(git default-branch)"'
git config --global alias.plb '!git fetch --all --prune && for branch in $(git for-each-ref --format "%(refname) %(upstream:track)" refs/heads | awk '\''$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'\''); do git branch -D "$branch"; done'
