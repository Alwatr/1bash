#!/bin/bash

function ffm() {
  local output_file=${!#}
  ffmpeg $@ \
    -strict experimental -movflags +faststart -benchmark \
    ${output_file}
}