TRANSITIONS=(
  fade
  grow
  outer
  wipe
)

WALLPAPER=$(find ~/.config/hypr/hyprlab-wpp -type f | shuf -n 1)
TRANSITION=$(printf "%s\n" "${TRANSITIONS[@]}" | shuf -n 1)

awww img "$WALLPAPER" --transition-type "$TRANSITION"
