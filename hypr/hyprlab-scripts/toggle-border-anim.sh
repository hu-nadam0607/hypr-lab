#!/usr/bin/env bash

# Állapotjelző fájl a RAM-ban
STATE_FILE="/tmp/hypr_border_anim_active"

# A te fix neonlila színed a konfigodból (0xccb026ff)
STATIC_BORDER="0xccb026ff"

if [ -f "$STATE_FILE" ]; then
    # === KIKAPCSOLÁS ===
    # Visszaadjuk a fix egyszínű neonlilát. Mivel egyszínű, a forgás láthatatlanná válik!
    hyprctl keyword general:col.active_border "$STATIC_BORDER"
    rm "$STATE_FILE"
else
    # === BEKAPCSOLÁS ===
    # Megadjuk a színátmenetet a fehér fénnyel. 
    # Mivel a konfigban a borderangle loopra van téve, a fehér csík azonnal elindul, és SOHASEM ÁLL MEG!
    hyprctl keyword general:col.active_border "0xccb026ff 0xffffffff 0xccb026ff 180deg"
    touch "$STATE_FILE"
fi
