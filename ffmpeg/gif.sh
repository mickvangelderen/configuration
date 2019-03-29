#!/usr/bin/env sh

start_time=1:12
duration=8

palette="/tmp/palette.png"

filters="fps=10,scale=1280:-1:flags=lanczos"

ffmpeg -v warning -ss $start_time -t $duration -i $1 -vf "$filters,palettegen=stats_mode=diff" -y $palette
ffmpeg -v warning -ss $start_time -t $duration -i $1 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=5:diff_mode=rectangle" -y $2
