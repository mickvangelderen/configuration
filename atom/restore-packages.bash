#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "$0")" && pwd)"

apm install --packages-file "$SCRIPT_DIRECTORY/package-list.txt"
