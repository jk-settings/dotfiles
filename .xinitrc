##### .xinitrc for dwm

cd ~

exec >>~/.xsession-errors 2>&1

export MANPATH=/usr/share/man:/usr/local/share/man:${MANPATH}
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:${PATH}

xset b off

xset r rate 200 40
xrdb -merge ~/.Xdefaults

exec dwmsd &
exec dwm

