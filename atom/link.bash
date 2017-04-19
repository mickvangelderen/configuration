#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"

link_folder="$HOME/.atom"
link_target_folder="$SCRIPT_DIRECTORY/.atom"

# Symlink the configuration files of this repository.
while IFS= read -r -d '' file; do
    link_path="$link_folder/$file"
    link_backup_path="${link_path}.backup"
    link_target_path="$link_target_folder/$file"

    if [ -f "$link_path" ]; then
      mv "$link_path" "$link_backup_path"
    fi

    if [ ! -L "$link_path" ]; then
      ln --symbolic --relative "$link_target_path" "$link_path"
    fi
done < <(find "$link_target_folder" -type f -printf "%P\0")
