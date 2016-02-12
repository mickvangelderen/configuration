#!/usr/bin/env bash

FROM="$MICK_CONFIGURATION_FOLDER/sublime-text-3"
TO=~/"AppData/Roaming/Sublime Text 3/Packages/User"

cp "$FROM/Default (Windows).sublime-keymap" "$TO"
cp "$FROM/Package Control.sublime-settings" "$TO"
cp "$FROM/Preferences.sublime-settings" "$TO"
