#!/usr/bin/env bash

DEFAULT_NAME="Screenshot_Area_$(date +%Y%m%d_%H%M%S).png"

# Először bekérjük a helyet, ahova menteni szeretnéd
FILE_PATH=$(zenity --file-selection --save --confirm-overwrite --filename="$HOME/Képek/$DEFAULT_NAME" --title="Kijelölt terület mentése mint...")

# Ha megvan a hely, jöhet a kijelölés és a fotó
if [ -n "$FILE_PATH" ]; then
    grim -g "$(slurp)" "$FILE_PATH"
fi
