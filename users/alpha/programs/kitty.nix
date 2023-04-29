{ pkgs, config, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "monospace";
      size = 14;
    };
    settings = with config.colorScheme.colors; {
      # settings
      window_padding_width = 18;
      cursor_shape = "underline";

      # tabs
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 2;
      tab_powerline_style = "slanted";
      active_tab_foreground = "#${base00}";
      active_tab_background = "#${base0D}";
      active_tab_font_style = "none";
      inactive_tab_foreground = "#${base06}";
      inactive_tab_background = "#${base02}";
      inactive_tab_font_style = "none";

      # splits
      active_border_color = "#${base02}";
      inactive_border_color = "#${base02}";

      # colors
      background = "#${base00}";
      foreground = "#${base06}";
      color0 = "#${base01}";
      color8 = "#${base02}";
      color1 = "#${base08}";
      color9 = "#${base08}";
      color2 = "#${base0B}";
      color10 = "#${base0B}";
      color3 = "#${base0A}";
      color11 = "#${base0A}";
      color4 = "#${base0D}";
      color12 = "#${base0D}";
      color5 = "#${base0E}";
      color13 = "#${base0E}";
      color6 = "#${base0C}";
      color14 = "#${base0C}";
      color7 = "#${base06}";
      color15 = "#${base07}";
      cursor = "#${base02}";
      cursor_text_color = "#${base00}";
      selection_foreground = "#${base06}";
      selection_background = "#${base02}";
    };
  };
}