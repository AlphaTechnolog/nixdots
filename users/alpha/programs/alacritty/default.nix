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
        padding.x = 32;
        padding.y = 32;
      };
      font =
        setfont "monospace"
        // {
          size = 12;
        };
      cursor = {
        style = {
          shape = "Beam";
          blinking = "on";
        };
      };
    };
  };
}
