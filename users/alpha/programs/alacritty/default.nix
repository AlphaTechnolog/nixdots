{
  pkgs,
  colors,
  ...
}: let
  setfont = import ./setfont.nix {};
  theme = import ./theming.nix {inherit colors;};
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = theme;
      mouse.hide_when_typing = true;
      window = {
        padding.x = 18;
        padding.y = 18;
        dynamic_padding = true;
      };
      font =
        setfont "monospace"
        // {
          size = 12;
        };
      cursor = {
        thickness = 0.2;
        style = {
          shape = "Beam";
          blinking = "on";
        };
      };
    };
  };
}
