#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

apm list --installed --bare | sed -e 's/@.*$//g' > "$SCRIPT_DIRECTORY/package-list.txt"
