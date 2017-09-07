[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
[[ -f ~/scripts/ifaceup ]] && ~/scripts/ifaceup
setxkbmap -option ctrl:nocaps
exec i3
