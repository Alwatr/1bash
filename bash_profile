export ONE_BASH="${ONE_BASH:-$DEV_TOOLS/1bash}"

for file in $ONE_BASH/src/*.sh; do
  if [ -r "$file" ]; then
    echo "import: $file"
    source "$file"
  fi
done
unset file

for file in $ONE_BASH/src/lib/*.sh; do
  if [ -r "$file" ]; then
    echo "import: $file"
    source "$file"
  fi
done
unset file

if [ ! -f "${HOME}/.inputrc" ]; then
  echo "link: ~/.inputrc -> 1bash/inputrc"
  ln -sf "${DEV_TOOLS}/1bash/inputrc" "${HOME}/.inputrc"
fi

if [ ! -f "${HOME}/.gitconfig" ]; then
  echo "link: ~/.gitconfig -> 1bash/gitconfig"
  ln -sf "${DEV_TOOLS}/1bash/gitconfig" "${HOME}/.gitconfig"
fi
