#!/bin/bash

set -e

# Run the stream for 11 hours (11 hours * 60 minutes * 60 seconds)
timeout=39600

# Start time
start_time=$(date +%s)

# Run the stream until the timeout is reached
while true; do
    # Check if 11 hours have passed
    #current_time=$(date +%s)
    #elapsed_time=$((current_time - start_time))
    #if [ $elapsed_time -ge $timeout ]; then
    #    echo "11 hours have passed. Restarting the stream..."
    #    sleep 10
    #    exit 0
    #fi

    # Run your ffmpeg command here
    ffmpeg -loglevel info -y -re \
        -stream_loop -1 -i ./video/loficafe.mkv \
        -f concat -safe 0 -i <((for f in ./mp3/rainforest/*.mp3; do echo "file $PWD/$f"; done) | shuf) \
        -c:v libx264 -preset veryfast -b:v 6800k -maxrate 6800k -bufsize 13600k \
        -framerate 25 -video_size 1280x720 -vf "format=yuv420p" -g 50 -shortest -strict experimental \
        -c:a aac -b:a 128k -ar 44100 \
        -map 0:v:0 -map 1:a:0 \
        -f flv rtmp://a.rtmp.youtube.com/live2/19h8-ury6-c1k1-ugtz-bzj1 \
        >> /app/output.log 2>&1

    # Sleep for a short duration
    #sleep 10
done
