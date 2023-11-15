#!/bin/bash

function convert2m4a() {
  input="$1"; shift;

  echo "Convert (-c:a aac -q:a 0.5 -ar 22050)"
  ffmpeg -i "$input" -vn -c:a aac -q:a 0.5 -ar 22050 $@ \
    -strict experimental -movflags +faststart -benchmark \
    "${input}.m4a"
}