#.xinitrc for dwm on XQuartz for Mac

cd ~

exec >>~/.xsession-errors 2>&1

export MANPATH=${MANPATH}:/usr/local/share/man
export PATH=${PATH}:/usr/local/bin/

#xsetroot -solid '#4a525a'
xmodmap -e 'remove Mod2 = Meta_L' -e 'add Mod1 = Meta_L'
xmodmap -e 'remove Mod2 = Meta_R' -e 'add Mod1 = Meta_R'
#xmodmap -e 'keysym Alt_L = Meta_L Alt_L'
#xmodmap -e 'keysym Alt_R = Meta_R Alt_R'
xset r rate 200 25

exec dwm

