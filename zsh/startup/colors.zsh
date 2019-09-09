# Set up zsh color environment
#
# Default environment assumes that you have 256 colors

if [ $_i3wm[color_env] = '256' ]; then
  _i3wm[ORANGE]="%{%F{214}%}"
else
  _i3wm[ORANGE]="%{%F{3}%}"
fi

# Default colors that fit within 16 bit colors
_i3wm[WHITE]="%{%F{15}%}"
_i3wm[GRAY]="%{%F{8}%}"
_i3wm[RED]="%{%F{9}%}"
_i3wm[BLUE]="%{%F{12}%}"
_i3wm[CYAN]="%{%F{14}%}"
_i3wm[YELLOW]="%{%F{11}%}"
_i3wm[GREEN]="%{%F{2}%}"
_i3wm[MAGENTA]="%{%F{13}%}"
