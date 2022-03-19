#!/bin/sh

# Keyboard repeat rate - 175ms delay before repeating
xset r rate 175 70

# Disable screen saver
xset s off

# Turn off moouse acceleration
xset m 0 0

# Turn off monitor after 25 minutes
xset dpms 0 0 1500

# Hide mouse when typing
xbanish & disown

# Set DPI
xrandr --dpi 96

# 27" 1440p     center
xrandr --output DP-2 --mode 2560x1440 --rate 165 --pos 0x0 --primary

# HiDPI displays are messed up in Xorg so using WQHD resolution without messing with blurry scaling or native resolution with extremely small UI
# 28" 4K        right
xrandr --output DP-0 --mode 2560x1440 --rate 60 --pos 2560x0

# Enable numlock after boot
numlockx &

# Set background to solid black
hsetroot -solid '#000000'

# Start the Window Manager
exec /usr/bin/i3

