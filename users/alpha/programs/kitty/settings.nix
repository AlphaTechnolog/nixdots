let
  colors = import ../../theme/colors.nix {};
in with colors; ''
# Eye Friendly Colors
# Created by https://github.com/decaycs
# Special
background #000000
foreground ${fg}
# Black
color0 ${black}
color8 ${dimblack}
# Red
color1 ${red}
color9 ${red}
# Green
color2  ${green}
color10 ${green}
# Yellow
color3  ${yellow}
color11 ${yellow}
# Blue
color4  ${blue}
color12 ${blue}
# Magenta
color5  ${magenta}
color13 ${magenta}
# Cyan
color6  ${cyan}
color14 ${cyan}
# White
color7  ${white}
color15 ${white}
# Cursor
cursor ${white}
cursor_text_color ${bg}
# Selection highlight
selection_foreground ${fg}
selection_background ${dimblack}
''
