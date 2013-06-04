#.xinitrc for dwm on XQuartz for Mac

cd ~

exec >>~/.xsession-errors 2>&1

export MANPATH=${MANPATH}:/usr/local/share/man
export PATH=${PATH}:/usr/local/bin

#xmodmap -e 'remove Mod2 = Meta_L' -e 'add Mod1 = Meta_L'
#xmodmap -e 'remove Mod2 = Meta_R' -e 'add Mod1 = Meta_R'
xset r rate 200 40

exec dwmstatus &
exec dwm

