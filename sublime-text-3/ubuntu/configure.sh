#!/usr/bin/env bash

FROM="$MICK_CONFIGURATION_FOLDER/sublime-text-3"
TO=~/".config/sublime-text-3/Packages/User"

cp "$FROM/Package Control.sublime-settings" "$TO"
cp "$FROM/Preferences.sublime-settings" "$TO"
