#!/usr/bin/env bash

git config --global user.name "Mick van Gelderen"
git config --global user.email "mickvangelderen@gmail.com"
git config --global core.editor "vim"
git config --global init.defaultBranch "main"

git config --global alias.default-branch '!f() { git symbolic-ref --short "refs/remotes/${1:-origin}/HEAD"; }; f'
git config --global alias.a 'add'
git config --global alias.p 'push'
git config --global alias.pf 'push --force-with-lease'
git config --global alias.po '!git push --set-upstream origin "$(git branch --show-current)"'
git config --global alias.pof '!git push --set-upstream origin "$(git branch --show-current)" --force-with-lease'
git config --global alias.bm '!f() { git branch -m "$@" && git branch --unset-upstream; }; f'
git config --global alias.c 'commit'
git config --global alias.wip 'commit -m WIP'
git config --global alias.awip 'commit -a -m WIP'
git config --global alias.ca 'commit --amend --no-edit'
git config --global alias.cae 'commit --amend'
git config --global alias.cf 'commit --fixup'
git config --global alias.cfl '!git commit --fixup $(git log --grep="^fixup!" --invert-grep -n 1 --format="%H")'
git config --global alias.r 'rebase --interactive --autosquash'
git config --global alias.new '!git fetch && git switch --create "$1" "$(git default-branch)" #'
git config --global alias.rom '!git fetch && git rebase --interactive --autosquash "$(git default-branch)"'
git config --global alias.rum '!git fetch && git rebase --interactive --autosquash "$(git default-branch upstream)"'
git config --global alias.smb '!f() { db=$(git default-branch) || return; base=$(git merge-base HEAD "$db") || { echo "error: no merge base with $db" >&2; return 2; }; GIT_SEQUENCE_EDITOR='\''sed -i "2,$ s/^pick /squash /"'\'' git rebase -i "$base" "$@"; }; f'
git config --global alias.plb '!git fetch --all --prune && for branch in $(git for-each-ref --format "%(refname) %(upstream:track)" refs/heads | awk '\''$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'\''); do git branch -D "$branch"; done'
