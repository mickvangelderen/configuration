#!/usr/bin/env bash
set -euo pipefail

usage() {
  printf 'Usage: %s INPUT [OUTPUT]\n' "$(basename "$0")" >&2
  printf 'Compresses INPUT to OUTPUT, or to INPUT-stem.compressed.mp4 when OUTPUT is omitted.\n' >&2
}

if [[ $# -lt 1 || $# -gt 2 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 2
fi

input=$1
if [[ ! -f "$input" ]]; then
  printf 'Input file not found: %s\n' "$input" >&2
  exit 1
fi

if [[ $# -eq 2 ]]; then
  output=$2
else
  input_dir=$(dirname -- "$input")
  input_name=$(basename -- "$input")
  input_stem=${input_name%.*}
  output="${input_dir}/${input_stem}.compressed.mp4"
fi

ffmpeg -i "$input" \
  -c:v libx264 -preset slow -tune animation -crf 26 \
  -c:a aac -b:a 96k \
  -movflags +faststart \
  "$output"
