#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIRECTORY/AGENTS.md"

print_and_run () {
    echo "$@"
    "$@"
}

link_agents_md () {
    local dir="$1"
    local name="$2"
    local link_path="$HOME/$dir/$name"

    print_and_run mkdir -p "$HOME/$dir"

    if [ -L "$link_path" ] || [ -e "$link_path" ]; then
        if [ -L "$link_path" ] && [ "$(readlink -f "$link_path")" = "$SOURCE" ]; then
            echo "$link_path already links to $SOURCE"
            return
        fi
        print_and_run rm "$link_path"
    fi

    print_and_run ln --symbolic "$SOURCE" "$link_path"
}

link_agents_md ".codex" "AGENTS.md"
link_agents_md ".claude" "CLAUDE.md"
