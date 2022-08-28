#!/usr/bin/env bash

THEME="$HOME/.config/leftwm/themes/current/rofi/powermenu.rasi"

rofi_command="rofi -no-config -theme $THEME"

# Options
shutdown="Shutdown"
reboot="Restart"
suspend="Suspend"
logout="Logout"

# Variable passed to rofi
options="$suspend\n$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 0)"
case $chosen in
    $shutdown)
      sudo runit-init 0
        ;;
    $reboot)
      sudo runit-init 6
        ;;
    $suspend)
      echo "TODO"
        ;;
    $logout)
      $HOME/.config/leftwm/themes/current/down && pkill leftwm
        ;;
esac
