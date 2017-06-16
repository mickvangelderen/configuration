#!/usr/bin/env bash

sudo -v

sudo add-apt-repository ppa:thomas-schiex/blender --yes
sudo apt-get update
sudo apt-get install blender --yes
