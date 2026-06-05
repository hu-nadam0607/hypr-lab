while inotifywait -e close_write ~/.config/waybar-lab; do killall -SIGUSR2 waybar; done
