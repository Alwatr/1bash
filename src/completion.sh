# shellcheck shell=sh disable=SC1091,SC2166,SC2268,SC3028,SC3044,SC3054
# Check for interactive bash and that we haven't already been sourced.
if [ "x${BASH_VERSION-}" != x -a "x${PS1-}" != x ]; then

  # Check for recent enough version of bash.
  if [ "${BASH_VERSINFO[0]}" -gt 4 ] ||
    [ "${BASH_VERSINFO[0]}" -eq 4 -a "${BASH_VERSINFO[1]}" -ge 2 ]; then

    for file in ${ONE_BASH}/src/completion.d/*; do
      if [ -r "$file" ]; then
        echo "import: $file"
        source "$file"
      fi
    done
    unset file
  fi
fi
