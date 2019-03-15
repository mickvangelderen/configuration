#!/usr/bin/env sh

# Suggested by https://obsproject.com/download as of 2019 march 15.

sudo -v

sudo add-apt-repository ppa:obsproject/obs-studio -y
sudo apt update
sudo apt install ffmpeg obs-studio -y

