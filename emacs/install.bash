#!/usr/bin/env bash

sudo --validate || exit

sudo apt-get install emacs25

git clone https://github.com/syl20bnr/spacemacs --branch develop ~/.emacs.d

git clone git@github.com:mickvangelderen/.spacemacs.d ~/.spacemacs.d
