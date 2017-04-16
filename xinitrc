[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
setxkbmap -option ctrl:nocaps
exec i3
