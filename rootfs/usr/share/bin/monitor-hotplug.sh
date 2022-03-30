#!/bin/bash
export DISPLAY=:0
export XAUTHORITY=${HOME}/.Xauthority
DS=$(loginctl show-session $(loginctl | grep gamer | awk '{print $1}' ) | grep "Type" | cut -d"=" -f2)
# Handle X11 docking.
if [[ " ${DS[*]} " =~ "x11" ]]; then
	# export required variables to open the display with xrandr
	/bin/su -mc 'export DISPLAY=:0 && export XAUTHORITY=${HOME}/.Xauthority && /usr/share/steamos-compositor-plus/bin/set_hd_mode.sh' - gamer

# Nothing else currently works. TODO: Find solution for wayland.
elif [[ " ${DS[*]} " =~ "wayland" ]]; then
	echo "Using Wayland. Docking is not currently supported. Aborting."
else
	echo "No display server identified. Do you have Xauthority?"
fi

exit 0
