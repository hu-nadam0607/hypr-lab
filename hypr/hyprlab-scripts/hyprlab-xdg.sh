#!/usr/bin/env bash
#  _   _                 _               _     
# | | | |_   _ _ __  _ __| |    __ _    | |__  
# | |_| | | | | '_ \| '__| |   / _` |---| '_ \ 
# |  _  | |_| | |_) | |  | |__| (_| |---| |_) |
# |_| |_|\__, | .__/|_|  |_____\__,_|   |_.__/ 
#        |___/|_|                              
#
# Hypr-Lab Portál Inicializáló Script (GNOME Fallback Támogatással)
# Cél: A Wayland alatti képernyőmegosztás (Discord, Vesktop, OBS) javítása.

# Rövid várakozás indításkor, hogy a Hyprland alapfolyamatai felálljanak
sleep 1

# 1. LÉPÉS: Minden potenciálisan futó vagy beragadt portál kényszerített leállítása.
# Mivel van GNOME a rendszeren, a gnome-portal kinyírása itt kritikus fontosságú!
killall -e xdg-desktop-portal-hyprland
killall -e xdg-desktop-portal-gnome
killall -e xdg-desktop-portal-gtk
killall -e xdg-desktop-portal

# 2. LÉPÉS: Környezeti változók frissítése a D-Bus felé.
# Tudatjuk a rendszerrel, hogy most a Hyprland munkamenet aktív (kis- és nagybetűvel is).
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=hyprland

# 3. LÉPÉS: A felhasználói systemd szolgáltatások leállítása a tiszta lapért.
# Ide bekerült a GNOME portál szolgáltatásának explicit leállítása is.
systemctl --user stop pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gnome
sleep 0.2

# 4. LÉPÉS: A portálok indítása a megfelelő logikai és időrendi sorrendben.

# Elsőként a Hyprland saját portálját indítjuk el a háttérben
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2

# Másodikként a GTK portált indítjuk el (ha létezik), ez felel a fájlkezelő ablakokért
if [ -f /usr/lib/xdg-desktop-portal-gtk ]; then
    /usr/lib/xdg-desktop-portal-gtk &
    sleep 0.5
fi

# Harmadikként az univerzális XDG főportált indítjuk el, ami összefogja a többit
/usr/lib/xdg-desktop-portal &
sleep 0.5

# 5. LÉPÉS: A szükséges multimédiás és portál szolgáltatások visszakapcsolása.
# A gnome-portal-t szándékosan KIHAGYJUK a visszakapcsolásból, hogy ne kavarjon be!
systemctl --user start pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland

echo "Hypr-Lab portálok sikeresen újraindítva a háttérben!"
