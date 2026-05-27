#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage: compress-latest-mp4.sh [DIRECTORY]

Find the newest .mp4 file in DIRECTORY, or $HOME if no directory is given,
and create a compressed MP4 beside it.

Environment overrides:
  MAX_WIDTH=1920      Downscale videos wider than this
  CRF=28              Higher is smaller/lower quality, lower is larger/better
  PRESET=slow         x264 preset
  AUDIO_BITRATE=128k  AAC audio bitrate
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

search_dir="${1:-$HOME}"
max_width="${MAX_WIDTH:-1920}"
crf="${CRF:-28}"
preset="${PRESET:-slow}"
audio_bitrate="${AUDIO_BITRATE:-128k}"

if [[ ! -d "$search_dir" ]]; then
  echo "Directory not found: $search_dir" >&2
  exit 1
fi

if [[ ! "$max_width" =~ ^[0-9]+$ ]]; then
  echo "MAX_WIDTH must be a positive integer, got: $max_width" >&2
  exit 1
fi

if [[ ! "$crf" =~ ^[0-9]+$ ]]; then
  echo "CRF must be an integer, got: $crf" >&2
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "ffmpeg is not installed or is not on PATH." >&2
  exit 1
fi

latest_file=""
while IFS= read -r -d '' entry; do
  latest_file="${entry#*$'\t'}"
  break
done < <(
  find "$search_dir" -maxdepth 1 -type f \
    \( -iname '*.mp4' -o -iname '*.MP4' \) \
    ! -iname '*-compressed.mp4' \
    ! -iname '*-compressed-*.mp4' \
    -printf '%T@\t%p\0' |
    sort -z -nr
)

if [[ -z "$latest_file" ]]; then
  echo "No uncompressed .mp4 files found in: $search_dir" >&2
  exit 1
fi

base="${latest_file%.*}"
output="${base}-compressed.mp4"

if [[ -e "$output" ]]; then
  output="${base}-compressed-$(date +%Y%m%d-%H%M%S).mp4"
fi

echo "Input:  $latest_file"
echo "Output: $output"
echo "Settings: max width ${max_width}, CRF ${crf}, preset ${preset}, audio ${audio_bitrate}"

ffmpeg \
  -hide_banner \
  -i "$latest_file" \
  -vf "scale='trunc(min(${max_width},iw)/2)*2':-2" \
  -c:v libx264 \
  -preset "$preset" \
  -crf "$crf" \
  -c:a aac \
  -b:a "$audio_bitrate" \
  -movflags +faststart \
  "$output"
