#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"

setup_configuration_directory () {
    local name="$1"

    local conf_file="$HOME/$name"
    local conf_dir="$HOME/${name}.d"
    local escaped_conf_dir="\$HOME/${name}.d"
    local source_conf_dir="$SCRIPT_DIRECTORY/${name}.d"

    # create the configuration directory if it doesn't exist.
    if [ ! -d "$conf_dir" ]; then
        mkdir "$conf_dir"

        # Move the original configuration file into the new directory if it
        # exists.
        if [ -f "$conf_file" ]; then
            mv "$conf_file" "$conf_dir"
        fi
    fi

    # Create a new configuration file that loads all configuration files in the
    # new configuration directory.
    if [ ! -f "$conf_file" ]; then
        cat > "$conf_file" << EOF
#!/usr/bin/env bash

# THIS IS A GENERATED FILE, DO NOT MODIFY BY HAND.

while IFS= read -r -d '' file; do
     . "\$file"
done < <(find -L "$escaped_conf_dir" -type f -print0)
EOF
    fi

    # Symlink the configuration files of this repository.
    while IFS= read -r -d '' file; do
        local link_target_path="$source_conf_dir/$file"
        local link_path="$conf_dir/$file"
        if [ ! -e "$link_path" ]; then
            ln --symbolic --relative "$link_target_path" "$link_path"
        fi
    done < <(find "$source_conf_dir" -type f -printf "%P\0")
}

setup_configuration_directory ".profile"
setup_configuration_directory ".bashrc"
