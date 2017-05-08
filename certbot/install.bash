#!/usr/bin/env bash

sudo -v

sudo add-apt-repository ppa:certbot/certbot --yes
sudo apt-get update
sudo apt-get install certbot --yes
