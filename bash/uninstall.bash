#!/usr/bin/env bash

while true; do
    echo "Remove configuration files and directories?"
    read -p " > " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_PATH="$SCRIPT_DIRECTORY/$SCRIPT_NAME"

print_and_run () {
    echo "$@"
    "$@"
}

remove_configuration_directory () {
    local name="$1"

    local conf_file="$HOME/$name"
    local moved_conf_file="$HOME/${name}.d/$name"

    local conf_dir="$HOME/${name}.d"
    local escaped_conf_dir="\$HOME/${name}.d"
    local source_conf_dir="$SCRIPT_DIRECTORY/${name}.d"


    # Restore original configuration file.
    if [ -f "$moved_conf_file" ]; then
        if [ -f "$conf_file" ]; then
            print_and_run rm "$conf_file"
        fi
        print_and_run mv "$moved_conf_file" "$conf_file"
    fi

    # Remove the configuration directory.
    if [ -d "$conf_dir" ]; then
        print_and_run rm -r "$conf_dir"
    fi
}

remove_configuration_directory ".profile"
remove_configuration_directory ".bashrc"
