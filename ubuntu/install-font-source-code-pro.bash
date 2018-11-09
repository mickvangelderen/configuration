#!/bin/sh

sudo -v

# ~/.fonts is now deprecated and that
# ~/.local/share/fonts should be used instead
INSTALL_DIR="/usr/local/share/fonts/source-code-pro"

echo "Installing source code pro to $INSTALL_DIR"

sudo mkdir -p "$INSTALL_DIR"

(sudo git clone \
   --branch "2.030R-ro/1.050R-it" \
   --depth 1 \
   'https://github.com/adobe-fonts/source-code-pro.git' \
   "$INSTALL_DIR" && \
sudo fc-cache -f -v "$INSTALL_DIR")
