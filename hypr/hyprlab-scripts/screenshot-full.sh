#!/usr/bin/env bash

# Alapértelmezett fájlnév generálása dátummal
DEFAULT_NAME="Screenshot_$(date +%Y%m%d_%H%M%S).png"

# Fájlkezelő ablak megnyitása a mentési hely kiválasztásához
FILE_PATH=$(zenity --file-selection --save --confirm-overwrite --filename="$HOME/Képek/$DEFAULT_NAME" --title="Képernyőkép mentése mint...")

# Ha a felhasználó nem nyomott Mégse-t (Cancel), akkor elkészítjük a képet
if [ -n "$FILE_PATH" ]; then
    grim "$FILE_PATH"
fi
