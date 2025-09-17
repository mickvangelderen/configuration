#!/usr/bin/env bash

cd "$(dirname "$0")"

set -euo pipefail

log(){ printf '[install] %s\n' "$*" >&2; }
die(){ printf '[install] ERROR: %s\n' "$*" >&2; exit 1; }

[[ $EUID -eq 0 ]] || die "Run as root (e.g., sudo bash $0)"

# --- Check for Kanto ORA4 presence (non-fatal if missing) ---
if grep -qi 'ORA4 by Kanto' /proc/asound/cards; then
  log "Detected Kanto ORA4 in /proc/asound/cards"
else
  die "ERROR: Did not detect 'ORA4 by Kanto' in /proc/asound/cards."
fi

# --- Install pactl (pulseaudio-utils) if missing ---
if ! command -v pactl >/dev/null 2>&1; then
  log "Installing pulseaudio-utils (provides pactl)…"
  apt-get update -y
  apt-get install -y pulseaudio-utils
else
  log "pactl already present"
fi

install -m 755 kanto-ora4-nudge.bash /usr/local/bin
log "Installed /usr/local/bin/kanto-ora4-nudge.bash"

# --- Create a user service for all users ---
install -d -m 755 /etc/systemd/user
cat >/etc/systemd/user/kanto-nudge-profiles.service <<'EOF'
[Unit]
Description=Kanto ORA4 audio wakeup nudge (profile toggle) at login
After=wireplumber.service pipewire-pulse.service

[Service]
Type=oneshot
ExecStart=/usr/local/bin/kanto-ora4-nudge.bash

[Install]
WantedBy=default.target
EOF
log "Installed /etc/systemd/user/kanto-nudge-profiles.service"

# --- Enable globally so every user session will run it at login ---
systemctl daemon-reload
systemctl --global enable kanto-nudge-profiles.service
log "Enabled kanto-nudge-profiles.service globally"
