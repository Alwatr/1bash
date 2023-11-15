#!/bin/bash

function exportGif() {
  # filename=$(basename ${1} .mp4)
  ffmpeg -i ${1} \
    -c:a aac -q:a 1 -ar 22050 -an \
    -strict experimental -movflags +faststart -benchmark \
    ${1}.mp4

  # convert out.${filename}.mp4 -delay 10 -loop 0 -layers optimize out.${filename}.gif
  # rm out.${filename}.mp4
}