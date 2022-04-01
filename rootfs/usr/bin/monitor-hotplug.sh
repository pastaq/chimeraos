#!/bin/bash

# Grab the required environment vars to do this
export DISPLAY=:0
export XUSER=$(loginctl | awk 'FNR==2{print $3}')
export XAUTHORITY=/home/$XUSER/.Xauthority
DS=$(loginctl show-session $(loginctl | grep $XUSER | awk '{print $1}' ) | grep "Type" | cut -d"=" -f2)

# Handle X11 docking.
if [[ " ${DS[*]} " =~ "x11" ]]; then
	# export required variables to open the display with xrandr
	#/bin/su -mc 'export DISPLAY=:0 && export XAUTHORITY=/home/$(loginctl | awk '"'"'FNR==2{print $3}'"'"')/.Xauthority && /usr/share/steamos-compositor-plus/bin/set_hd_mode.sh' - $XUSER
	# for now, restart lightdm. TODO: Replace this with a steamcompmgr flag to redetet "dpy" render target with correct bounds.
	systemctl restart lightdm 

# Nothing else currently works. TODO: Find solution for wayland.
elif [[ " ${DS[*]} " =~ "wayland" ]]; then
	echo "Using Wayland. Docking is not currently supported. Aborting."
else
	echo "No display server identified. Do you have Xauthority?"
fi

exit 0
