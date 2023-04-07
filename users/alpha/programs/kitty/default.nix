{
  colors,
  pkgs,
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 14;
    };
    settings = with colors; {
      # settings
      window_padding_width = 18;
      cursor_shape = "underline";
      background_opacity = "0.65";

      # tabs
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 1;
      tab_powerline_style = "slanted";
      active_tab_foreground = bg;
      active_tab_background = accent;
      active_tab_font_style = "none";
      inactive_tab_foreground = fg;
      inactive_tab_background = bg-lighter;
      inactive_tab_font_style = "none";

      # splits
      active_border_color = light-black;
      inactive_border_color = bg-lighter;

      # colors
      background = bg;
      foreground = fg;
      color0 = black;
      color8 = light-black;
      color1 = red;
      color9 = red;
      color2 = green;
      color10 = green;
      color3 = yellow;
      color11 = yellow;
      color4 = accent; # blue
      color12 = accent; # blue
      color5 = magenta;
      color13 = magenta;
      color6 = cyan;
      color14 = cyan;
      color7 = white;
      color15 = white;
      cursor = light-black;
      cursor_text_color = bg;
      selection_foreground = white;
      selection_background = dimblack;
    };
  };
}
