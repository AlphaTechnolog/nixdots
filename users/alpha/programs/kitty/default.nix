{ pkgs }:

{
  programs.kitty = {
    enable = true;
    extraConfig = import ./settings.nix;
    settings = {
      window_padding_width = 20;
      confirm_os_window_close = 0;
      cursor_shape = "underline";
      cursor_underline_thickness = "0.5";
      modify_font = "cell_height 4px";
      background_opacity = "0.85";
    };
    font = {
      size = 11;
      name = "Liga SFMono Nerd Font";
    };
  };
}
