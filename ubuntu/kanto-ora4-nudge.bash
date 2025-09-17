#!/usr/bin/env bash
set -euo pipefail

log(){ printf '[nudge] %s\n' "$*" >&2; }

# 0) Must talk to your user session (not root)
if ! pactl info >/dev/null 2>&1; then
  log "ERROR: pactl cannot connect (don't use sudo)."
  exit 1
fi

# 1) Find the Kanto card index (only assumption: card type/name contains Kanto_Audio_ORA4)
CARD="$(pactl list cards short | awk '/Kanto_Audio_ORA4/ {print $1; exit}')"
if [[ -z "${CARD:-}" ]]; then
  log "ERROR: Kanto_Audio_ORA4 card not found."
  pactl list cards short
  exit 1
fi
log "Found Kanto card index: $CARD"

# 2) Grab the card block once
CARD_BLOCK="$(pactl list cards | sed -n "/Card #$CARD/,/^\s*$/p")"

# 3) Ensure both profiles exist
if ! grep -q 'output:analog-stereo' <<<"$CARD_BLOCK"; then
  log "ERROR: analog profile (output:analog-stereo) not available on this card."
  printf "%s\n" "$CARD_BLOCK" | grep -E 'Profiles:|output:' -A99
  exit 1
fi
if ! grep -q 'output:iec958-stereo' <<<"$CARD_BLOCK"; then
  log "ERROR: digital IEC958 profile (output:iec958-stereo) not available on this card."
  printf "%s\n" "$CARD_BLOCK" | grep -E 'Profiles:|output:' -A99
  exit 1
fi

# 4) Log current active profile
ACTIVE="$(printf "%s\n" "$CARD_BLOCK" | awk -F': ' '/Active Profile:/{print $2; exit}')"
log "Active profile before: ${ACTIVE:-unknown}"

# 5) Switch to Analog, then back to Digital (IEC958)
log "Switching to output:analog-stereo"
pactl set-card-profile "$CARD" output:analog-stereo || { log "ERROR: failed to set analog"; exit 1; }
sleep 0.4

log "Switching back to output:iec958-stereo"
pactl set-card-profile "$CARD" output:iec958-stereo || { log "ERROR: failed to set iec958"; exit 1; }
sleep 0.4

# 6) Show final active profile for confirmation
FINAL="$(pactl list cards | sed -n "/Card #$CARD/,/^\s*$/p" | awk -F': ' '/Active Profile:/{print $2; exit}')"
log "Active profile after:  ${FINAL:-unknown}"

# 7) (Optional) show sink state for the sink(s) that belong to this card ONLY
for SID in $(pactl list short sinks | awk '{print $1}'); do
  if pactl list sinks | sed -n "/^Sink #$SID/,/^\s*$/p" | grep -q "Card: #$CARD"; then
    log "Sink #$SID state for this card:"
    pactl list sinks | sed -n "/^Sink #$SID/,/^\s*$/p" | grep -E 'Name:|State:|Mute:|Volume:|Active Port'
  fi
done
