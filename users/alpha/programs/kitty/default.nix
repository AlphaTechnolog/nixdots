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
    };
    font = {
      size = 10;
      name = "Iosevka Nerd Font";
    };
  };
}
