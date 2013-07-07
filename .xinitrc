##### .xinitrc for dwm on XQuartz for Mac

cd ~

exec >>~/.xsession-errors 2>&1

export MANPATH=${MANPATH}:/usr/local/share/man
export PATH=${PATH}:/usr/local/bin

xset b off

xset r rate 200 40
xrdb -merge ~/.Xdefaults

exec dwmsd &
exec dwm

