#.xinitrc for dwm on XQuartz for Mac

cd ~

exec >>~/.xsession-errors 2>&1

export MANPATH=${MANPATH}:/usr/local/share/man
export PATH=${PATH}:/usr/local/bin/

export DATE=`date +"%Y-%m-%d"`

while true
do
  xsetroot -name "$DATE"
  sleep 3600
done &

#xsetroot -solid '#4a525a'
xmodmap -e 'remove Mod2 = Meta_L' -e 'add Mod1 = Meta_L'

exec dwm

