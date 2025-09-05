# c2webp - Converts images (JPEG, PNG, TIFF) to WebP format.
c2webp() {
  local input="$1"
  # local quality="${2:-75}" # Use positional parameter for quality
  local options="${*:3}"   # Capture all remaining arguments as options
  local outputFile

  # --- Input Validation ---
  if [ -z "$options" ]; then
    echo "Usage: c2webp <input_path> [options]" >&2 # Error to stderr
    echo "  <input_file>:  Path to a single image file or a directory." >&2
    echo "  [options]:     Optional.  Additional cwebp options (e.g., -mt, -af)." >&2
    echo "Example: c2webp image.jpg -progress -preset picture -mt -m 6 -af -q 85" >&2
    echo "Example: c2webp images_directory/ -progress -preset photo" >&2
    return 1
  fi

  if ! command -v cwebp &>/dev/null; then
    echo "Error: cwebp command not found.  Please install the WebP tools." >&2
    echo "  (e.g., 'apt install webp' on Debian/Ubuntu, 'brew install webp' on macOS, press 'Alt+F4' in Windows)." >&2
    return 1
  fi

  # --- Single File Conversion ---
  if [ -f "$input" ]; then
    # Avoid double .webp.webp extensions.  Also handles existing .webp files.
    outputFile="${input}.webp"

    echo "Processing: $input"
    cwebp $options "$input" -o "$outputFile"
    if [ $? -eq 0 ]; then # Check the exit code of cwebp
      echo "Converted: $input -> $outputFile"
    else
      echo "Error: cwebp failed for $input" >&2
      return 1 # Return error if cwebp fails
    fi

  # --- Directory Conversion ---
  elif [ -d "$input" ]; then
    # Find supported image files (JPEG, PNG, TIFF, Gif) within the directory.
    find "$input" -type f \( -iname "*.jpeg" -o -iname "*.jpg" -o -iname "*.png" -o -iname "*.tiff" -o -iname "*.tif" -o -iname "*.gif" \) -print0 |
      while IFS= read -r -d $'\0' file; do
        outputFile="${file}.webp"
        echo -e "\n\nProcessing: $file"
        cwebp $options "$file" -o "$outputFile"
        if [ $? -eq 0 ]; then
          echo "Converted: $file -> $outputFile"
        else
          echo "Error: cwebp failed for $file" >&2
          # Don't return here; continue processing other files in the directory.
        fi
      done

  else
    echo "Error: Invalid input. '$input' is not a file or directory." >&2
    return 1
  fi
}

# Check if the script is being sourced or executed directly
# if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
#   c2webp "$@"
# fi
