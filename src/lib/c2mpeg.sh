# A wrapper function for ffmpeg to simplify common conversions.
# It automatically adds useful flags for web-compatible MP4 files.
# Usage: ffm [ffmpeg_input_options] <input_file> <output_file>
function ffm {
  echo 'ffm'

  # Use local variables to avoid affecting the global shell environment.

  # Capture all arguments except the very last one.
  # These are considered the input file and its associated options.
  local input_args=("${@:1:$#-1}")

  # Capture the very last argument, which is designated as the output file.
  local output_file="${!#}"

  # Run the ffmpeg command.
  # "${input_args[@]}" expands array elements as separate, quoted arguments.
  caffeinate -i `# Prevent mac sleep during encoding` \
    ffmpeg \
    "${input_args[@]}" \
    -flags +global_header `# Add a global header for better compatibility` \
    -movflags +faststart `# Move metadata to the start for web streaming` \
    -benchmark `# Print timing and resource usage info after conversion` \
    "$output_file"

  # -map_metadata 0 `# Copy metadata from the first input` \
}

function extract-frame {
  echo 'extract-frame from movie'

  local input="$1"
  shift
  local time="${1:-00:00:00}"
  shift

  ffmpeg -i "${input}" -ss "${time}" -frames:v 1 -q:v 1 "$@" "${input%.*}.jpeg"
}

function ffmeta {
  echo 'ffmeta'

  local input="$1"
  shift
  local metadata="${1:-}"
  shift
  local cover="${1:-}"
  shift

  if [ -z "${input}" ]; then
    echo 'Usage: ffmeta <input_file> [metadata_file] [cover_image]
If metadata_file is not specified, it will be used <input_file>.metadata.txt
If metadata_file is not existing, it will be generated from the input file.
If cover_image is not specified and <input_file>.cover.jpg is existing, it will be used.
'
    return 1
  fi

  if [ -z "$metadata" ]; then
    metadata="${input%.*}.metadata.txt"
  fi

  if [ ! -f "$metadata" ]; then
    ffmpeg -i "${input}" -f ffmetadata "${input%.*}.metadata.txt"
    return 1
  fi

  if [ -z "$cover" ] && [ -f "${input%.*}.cover.jpg" ]; then
    cover="${input%.*}.cover.jpg"
  fi
  if [ -z "$cover" ] && [ -f "${input%.*}.cover.jpeg" ]; then
    cover="${input%.*}.cover.jpeg"
  fi

  if [ -z "$cover" ]; then
    ffm -i "${input}" -i "${metadata}" -map_chapters -1 -map_metadata 1 -c copy "$@" "${input%.*}.meta.${input##*.}"
  else
    ffm -i "${input}" -i "${cover}" -i "${metadata}" -map_chapters -1 -map 0 -map 1 -map_metadata 2 -c copy -disposition:v attached_pic "$@" "${input%.*}.meta.${input##*.}"
  fi
}

function c2m4a {
  echo 'c2m4a'

  local input="$1"
  shift
  local quality="$1"
  shift

  if [ -f "$input" ]; then
    ffprobe "$input"
    echo -e '\n---\n'
  fi

  if [ -z "$quality" ]; then
    echo 'example: c2m4a ./audio.mp3 0.6 -ac 1 -af "pan=mono|c0=c0,atempo=1.2" -ar 24000 -map_chapters -1
-af "pan=mono|c0=c0,silenceremove=start_periods=1:start_duration=0:start_threshold=-45dB:stop_periods=-1:stop_duration=2:stop_threshold=-45dB,dynaudnorm=f=150:g=15,loudnorm=I=-19:TP=-1.5:LRA=11,atempo=1.2"
-ss 00:10:00 -to 00:11:00
loudnorm=I=-16 (stereo)
'
    return 1
  fi

  if [[ "${input##*.}" != "m4a" ]]; then
    local output="${input%.*}.m4a"
  else
    local output="${input%.*}.compressed.m4a"
  fi

  ffm -i "${input}" -vn -c:a aac -q:a "${quality}" "$@" "${output}"
}

function c2mp4 {
  echo 'c2mp4'

  local input="$1"
  shift
  local crf="$1"
  shift

  if [ -f "$input" ]; then
    ffprobe "$input"
    echo -e '\n---\n'
  fi

  if [ -z "$crf" ]; then
    echo 'Usage: c2mp4 <input_file> <crf> [options]
Notes:
crf: 30 for best compression, 28 for good compression, 26 for good quality, 24 for best quality.
-preset (slow, slower, veryslow)
-tune (film, animation, grain, stillimage, psnr, ssim, fastdecode, zerolatency)
-pix_fmt (yuv420p, yuv444p, gray)
-vf "setpts=PTS/1.2,fps=24,scale=1920:-2:flags=lanczos,mpdecimate=hi=64*85:lo=64*10:frac=0.33" -fps_mode vfr -af "pan=mono|c0=c0,atempo=1.2" 
-vf "setpts=PTS/60,fps=12,scale=960:-2:flags=lanczos" -an
-ac 1 -c:a aac -q:a 0.5 -ar 24000
-af "pan=mono|c0=c0,silenceremove=start_periods=1:start_duration=0:start_threshold=-45dB:stop_periods=-1:stop_duration=2:stop_threshold=-45dB,dynaudnorm=f=150:g=15,loudnorm=I=-19:TP=-1.5:LRA=11,atempo=1.2"
-map_chapters -1
-ss 00:10:00 -to 00:11:00
-shortest

example: c2mp4 ./video.mov 28 -an
'
    return 1
  fi

  if [[ "${input##*.}" != "mp4" ]]; then
    local output="${input%.*}.mp4"
  else
    local output="${input%.*}.compressed.mp4"
  fi

  ffm -i "$input" -c:v libx264 -profile:v high -crf ${crf} "$@" "${output}"
}

function c2mp4_ha {
  echo 'c2mp4_ha'

  local input="$1"
  shift
  local quality="$1"
  shift

  if [ -f "$input" ]; then
    ffprobe "$input"
    echo -e '\n---\n'
  fi

  if [ -z "$quality" ]; then
    echo 'Usage: c2mp4_ha <input_file> <quality> [options]
Notes:
quality: 0~100
-vf "setpts=PTS/1.2,fps=24,scale=1920:-2:flags=lanczos,mpdecimate=hi=64*85:lo=64*10:frac=0.33" -fps_mode vfr -af "pan=mono|c0=c0,atempo=1.2" 
-vf "setpts=PTS/60,fps=12,scale=960:-2:flags=lanczos" -an
-ac 1 -c:a aac -q:a 0.5 -ar 24000
-af "pan=mono|c0=c0,silenceremove=start_periods=1:start_duration=0:start_threshold=-45dB:stop_periods=-1:stop_duration=2:stop_threshold=-45dB,dynaudnorm=f=150:g=15,loudnorm=I=-19:TP=-1.5:LRA=11,atempo=1.2"
-map_chapters -1
-ss 00:10:00 -to 00:11:00
-shortest

example: c2mp4_ha ./video.mov 50 -an
'
    return 1
  fi

  if [[ "${input##*.}" != "mp4" ]]; then
    local output="${input%.*}.mp4"
  else
    local output="${input%.*}.compressed.mp4"
  fi

  ffm -i "$input" -c:v h264_videotoolbox -profile:v high -q:v ${quality} "$@" "${output}"
}

function c2mp5 {
  echo 'c2mp5'

  local input="$1"
  shift
  local crf="$1"
  shift

  if [ -f "$input" ]; then
    ffprobe "$input"
    echo -e '\n---\n'
  fi

  if [ -z "$crf" ]; then
    echo 'Usage: c2mp5 <input_file> <crf> [options]
Notes:
crf: 34 for best compression, 32 for good compression, 30 for good quality, 28 for best quality.
-preset (slow, slower, veryslow)
-tune (psnr, ssim, grain, fastdecode, zerolatency)
-vf "setpts=PTS/1.2,fps=24,scale=1920:-2:flags=lanczos,mpdecimate=hi=64*85:lo=64*10:frac=0.33" -fps_mode vfr -af "pan=mono|c0=c0,atempo=1.2" 
-vf "setpts=PTS/60,fps=12,scale=960:-2:flags=lanczos" -an
-ac 1 -c:a aac -q:a 0.5 -ar 24000
-map_chapters -1
-ss 00:10:00 -to 00:11:00
-shortest

example: c2mp5 ./video.mov 28 -an
'
    return 1
  fi

  if [[ "${input##*.}" != "mp4" ]]; then
    local output="${input%.*}.mp4"
  else
    local output="${input%.*}.compressed.mp4"
  fi

  ffm -i "$input" -c:v libx265 -profile:v main10 -crf ${crf} "$@" "${output}"
}

function c2mp5_ha {
  echo 'c2mp5_ha'

  local input="$1"
  shift
  local quality="$1"
  shift

  if [ -f "$input" ]; then
    ffprobe "$input"
    echo -e '\n---\n'
  fi

  if [ -z "$quality" ]; then
    echo 'Usage: c2mp5 <input_file> <quality> [options]
Notes:
quality: 0~100
-profile:v main10 -vf "format=p010le" 
-vf "setpts=PTS/1.2,fps=24,scale=1920:-2:flags=lanczos,mpdecimate=hi=64*85:lo=64*10:frac=0.33" -fps_mode vfr -af "pan=mono|c0=c0,atempo=1.2" 
-vf "setpts=PTS/60,fps=12,scale=960:-2:flags=lanczos" -an
-ac 1 -c:a aac -q:a 0.5 -ar 24000
-map_chapters -1
-ss 00:10:00 -to 00:11:00
-shortest

example: c2mp5 ./video.mov 28 -an
'
    return 1
  fi

  if [[ "${input##*.}" != "mp4" ]]; then
    local output="${input%.*}.mp4"
  else
    local output="${input%.*}.compressed.mp4"
  fi

  ffm -i "$input" -c:v hevc_videotoolbox -q:v ${quality} "$@" "${output}"
}
