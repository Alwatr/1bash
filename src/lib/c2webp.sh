# c2webp - Converts images (JPEG, PNG, TIFF) to WebP format.
c2webp() {
	local input="$1"
	# local quality="${2:-75}" # Use positional parameter for quality
	local options="${*:3}" # Capture all remaining arguments as options
	local outputFile

	# --- Input Validation ---
	if [ -z "$options" ]; then
		echo "Usage: c2webp <input_path> [options]" >&2 # Error to stderr
		echo "  <input_file>: Path to a single image file or a directory." >&2
		echo "  -preset:      Preset for the encoding (default, photo, picture, drawing, icon, text)." >&2
		echo "  [options]:    Optional.  Additional cwebp options (e.g., -mt, -af)." >&2
		echo "Example: c2webp image.jpg -preset picture -progress -mt -m 6 -af -v -q 78" >&2
		echo "Example: c2webp images_directory/ -preset photo -progress -mt -m 6 -af -v -q 78" >&2
		return 1
	fi

	if ! command -v cwebp &>/dev/null; then
		echo "Error: cwebp command not found.  Please install the WebP tools." >&2
		echo "  (e.g., 'apt install libwebp-dev' on Debian/Ubuntu, 'apk add libwebp-tools' on Alpine, 'brew install webp' on macOS and press 'Alt+F4' in Windows)." >&2
		return 1
	fi

	# --- Single File Conversion ---
	if [ -f "$input" ]; then
		# Avoid double .webp.webp extensions. Also handles existing .webp files.
		outputFile="${input}.webp"

		echoStep "Compressing: $input"
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
		find "$input" -type f \
			\( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" \
			-o -name "*.gif" -o -name "*.tiff" -o -name "*.tif" \) \
			! -name "*.webp" |
			while read -r file; do
				outputFile="${file}.webp"
				if [ ! -f "${file}.webp" ] || [ "$file" -nt "${file}.webp" ]; then
					echoStep "Compressing: $file"
					cwebp $options "$file" -o "$outputFile"
				else
					echo "Skipping (file exists): $outputFile"
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
