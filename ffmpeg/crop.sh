#!/usr/bin/env sh

ffmpeg -i crop_in.mkv -filter:v "crop=700:950:70:0" -c:v libx264 -crf 17 -c:a copy crop_out.mkv

