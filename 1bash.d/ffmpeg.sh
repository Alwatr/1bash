#!/bin/bash

function ffm() {
  local output_file=${!#}
  ffmpeg $@ \
    -strict experimental -movflags +faststart -benchmark \
    ${output_file}
}

function exportGif() {
  # filename=$(basename ${1} .mp4)
  ffm -i ${1} \
    -c:a aac -q:a 1 -ar 22050 -an \
    ${1}.mp4

  # convert out.${filename}.mp4 -delay 10 -loop 0 -layers optimize out.${filename}.gif
  # rm out.${filename}.mp4
}

function convert2m4a() {
  input="$1"; shift;

  echo "Convert (-c:a aac -q:a 0.5 -ar 22050)"
  ffm -i "$input" -vn -c:a aac -q:a 0.5 -ar 22050 $@ \
    "${input}.m4a"
}