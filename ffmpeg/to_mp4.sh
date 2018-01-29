# https://blog.learnosity.com/2010/12/convert-flv-to-mp4-with-ffmpeg-howto/
ffmpeg -i "$1" -vcodec copy -acodec copy "$2"
