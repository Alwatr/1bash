echoColor() {
  # 1: red, 2: green, 3: yellow, 4: blue, 5: purple, 6: cyan, 7: light gray
  echo -e "\x1b[0;3$1m$2\x1b[0m"
}

echoStep() {
  echoColor 6 "\n🔸 $1\n"
}

echoDone() {
  echoColor 2 "\n✅ ${1:-Done ;)}\n"
}

echoWarn() {
  echoColor 3 "⚠️  $1"
}

echoError() {
  echoColor 1 "❌ ${1:-Error :(}\n"
}

echoGap() {
  echo ''
  # [ "${1:-}" == "2" ] && echo ''
}

echoLogo() {
  cat "$ALWATR_LIB/logo"
}

error() {
  echoError "$1"
  exit 1
}

waitForEnter() {
  echo ''
  read -p "🔹 Press enter to continue"
  echo ''
}

confirm() {
  read -r -p "${1:-Are you sure? [y/N]} " response
  case "$response" in
    [yY][eE][sS]|[yY])
      true
      ;;
    *)
      false
      ;;
  esac
}
