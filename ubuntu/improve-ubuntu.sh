#!/usr/bin/env bash

# These tools have helped me write this script to modify ubuntu to my liking.
# gsettings list-recursively
# dconf watch /
# compizconfig-settings-manager

############################################################################
# Hotkeys
############################################################################

# Disable keybindings that are in the way or annoying.
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '' # Disable original <Control><Alt>l keybinding.
gsettings set org.compiz.integrated show-hud "@as []" # Disable show hud to allow Alt-D in browser.
dconf write /org/compiz/profiles/unity/plugins/unityshell/show-menu-bar "'Disabled'"
dconf write /org/compiz/profiles/unity/plugins/unityshell/lock-screen "'Disabled'"

# Focus another workspace.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Primary><Alt>h']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Primary><Alt>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Primary><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Primary><Alt>l']"

# Move windows to another workspace.
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Primary><Shift><Alt>h']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-down "['<Primary><Shift><Alt>j']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-up "['<Primary><Shift><Alt>k']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Primary><Shift><Alt>l']"

# Focus a specific workspace.
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>j']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>k']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>l']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>semicolon']"

# Move window to a specific workspace. (Does not work...)
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "['<Super><Shift>j']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2 "['<Super><Shift>k']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3 "['<Super><Shift>l']"
# gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4 "['<Super><Shift>semicolon']"

############################################################################
# Desktop
############################################################################

# Select radiance theme.
dconf write /org/gnome/desktop/wm/preferences/theme "'Radiance'"
dconf write /org/gnome/desktop/interface/cursor-theme "'DMZ-White'"
dconf write /org/gnome/desktop/interface/gtk-theme "'Radiance'"
dconf write /org/gnome/desktop/interface/icon-theme "'ubuntu-mono-light'"

# Create 4 workspaces in a line.
dconf write /org/compiz/profiles/unity/plugins/core/hsize 4
dconf write /org/compiz/profiles/unity/plugins/core/vsize 1

# Make workspace switching instant.
dconf write /org/compiz/profiles/unity/plugins/wall/slide-duration 0.10

# Auto hide task bar.
dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode "1"
dconf write /org/compiz/profiles/unity/plugins/unityshell/reveal-trigger "1"
dconf write /org/compiz/profiles/unity/plugins/unityshell/edge-responsiveness "8.0"

# Add show desktop icon.
dconf write /com/canonical/unity/launcher/favorites "['application://chromium-browser.desktop', 'application://org.gnome.Terminal.desktop', 'application://org.gnome.Nautilus.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://expo-icon', 'unity://devices']"
dconf write /com/canonical/unity/launcher/favorites "['application://chromium-browser.desktop', 'application://org.gnome.Terminal.desktop', 'application://org.gnome.Nautilus.desktop', 'application://unity-control-center.desktop', 'unity://running-apps', 'unity://desktop-icon', 'unity://expo-icon', 'unity://devices']"

############################################################################
# Terminal
############################################################################

# Obtain default terminal id, strip leading and trailing apostrophe character.
terminal_guid_quoted=$(gsettings get org.gnome.Terminal.ProfilesList default)
terminal_guid=${terminal_guid_quoted:1:-1}

# Tango palette.
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/palette "['rgb(0,0,0)', 'rgb(204,0,0)', 'rgb(78,154,6)', 'rgb(196,160,0)', 'rgb(52,101,164)', 'rgb(117,80,123)', 'rgb(6,152,154)', 'rgb(211,215,207)', 'rgb(85,87,83)', 'rgb(239,41,41)', 'rgb(138,226,52)', 'rgb(252,233,79)', 'rgb(114,159,207)', 'rgb(173,127,168)', 'rgb(52,226,226)', 'rgb(238,238,236)']"

# White text on white background.
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/use-theme-colors "false"
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/foreground-color "'rgb(255,255,255)'"
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/background-color "'rgb(0,0,0)'"

# 90% opaque background.
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/use-transparent-background "true"
dconf write /org/gnome/terminal/legacy/profiles:/:${terminal_guid}/background-transparency-percent "10"
