
LID="/proc/acpi/button/lid/LID/state"

a=$(cat /proc/acpi/button/lid/LID/state | grep -i open)
[[ -z "$a"  ]] && xrandr --output eDP-1 --off

# Start ssh-agent
eval $(ssh-agent -s)

# load Xresources
xrdb -all $HOME/.Xresources

# and add the keys
ssh-add ~/.ssh/gogs
ssh-add ~/.ssh/id_rsa.ansible

setxkbmap -option compose:ralt &
xmodmap -e "keycode 113 = Super_L"  # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L"  # make sure X keeps it out of the mod1 group

# Statusbar loop
#while true; do
#   xsetroot -name "$(tput setaf 31; slstatus)"
#done &
#while true;  do  /usr/local/bin/dwm > /dev/null; done;
#exec dwm

# Autostart section
exec i3
