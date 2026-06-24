#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

# Collect all images, excluding videos, bitmaps, and _1 duplicates
mapfile -t files < <(
  find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \
       -o -iname "*.gif" -o -iname "*.webp" \) \
  | grep -v '_1\.' \
  | sort
)

# Build label → path map, stripping date-time prefixes and extensions
declare -A map
labels=()

for f in "${files[@]}"; do
  base=$(basename "$f")
  ext="${base##*.}"
  label=$(echo "$base" \
    | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}-[0-9]\{2\}-//' \
    | sed 's/\.[^.]*$//' \
    | sed 's/[-_]/ /g')
  # Disambiguate collisions (e.g. Lake.gif vs Lake.webp) by appending the extension
  if [[ "${map[$label]+x}" ]]; then
    label="$label ($ext)"
  fi
  map["$label"]="$f"
  labels+=("$label")
done

choice=$(printf '%s\n' "${labels[@]}" | sort -f | wofi --dmenu --prompt "Wallpaper:" --width 520 --height 500)
[[ -z "$choice" ]] && exit 0

wp="${map[$choice]}"
awww img "$wp" --transition-type fade
wal -i "$wp"

pkill waybar && waybar &
eww reload
swaync-client -R
