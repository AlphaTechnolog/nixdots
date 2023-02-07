{ pkgs }:

{
  programs.kitty = {
    enable = true;
    extraConfig = import ./settings.nix;
    settings = {
      window_padding_width = 20;
      confirm_os_window_close = 0;
      cursor_shape = "beam";
      cursor_beam_thickness = "1";
      background_opacity = "1.0";
      modify_font = "cell_height 3px";
    };
    font = {
      size = 12;
      name = "monospace";
    };
  };
}
