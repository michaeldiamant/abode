gw() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -x "$dir/gradlew" ]]; then
      "$dir/gradlew" "$@"
      return
    fi
    dir="$(dirname "$dir")"
  done
  echo "No gradlew found in this directory or its parents." >&2
  return 1
}
