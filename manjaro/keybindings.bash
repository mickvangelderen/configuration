#!/usr/bin/env bash

# Set favorite apps.
gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'emacs.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Terminal.desktop', 'gnome-tweak-tool.desktop']"

# Disable mouse acceleration.
gsettings set org.gnome.desktop.peripherals.mouse accel-profile "'flat'"

# Use 4 workspaces.
gsettings set org.gnome.shell.overrides dynamic-workspaces "false"
gsettings set org.gnome.desktop.wm.preferences num-workspaces "4"

# Switch to workspace relatively.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Primary><Alt>h']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Primary><Alt>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Primary><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Primary><Alt>l']"

# Move window to another workspace relatively.
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Primary><Shift><Alt>h']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Primary><Shift><Alt>j']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Primary><Shift><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Primary><Shift><Alt>l']"

# Focus a specific workspace.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>l']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>semicolon']"

# Move window to a specific workspace. (Does not work on ubuntu, havent tried on manjaro...)
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>j']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Shift>k']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Shift>l']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>semicolon']"

