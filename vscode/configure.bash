#!/usr/bin/env bash

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SETTINGS_DIR="${HOME}/.config/Code/User"
BACKUP_PATH="${SETTINGS_DIR}/settings.json.bup"
LINK_PATH="${SETTINGS_DIR}/settings.json"
TARGET_PATH="${SCRIPT_DIRECTORY}/settings.json"

if [ -L "${LINK_PATH}" ]; then
	echo "A link already exists at ${LINK_PATH}, move or remove it."
	exit -1
fi

if [ -f "${BACKUP_PATH}" ]; then
	echo "A backup already exists at ${BACKUP_PATH}, move or remove it."
	exit -1
fi

if [ -f "${LINK_PATH}" ]; then
	mv "${LINK_PATH}" "${BACKUP_PATH}"
fi

ln --symbolic --no-target-directory "${TARGET_PATH}" "${LINK_PATH}"

