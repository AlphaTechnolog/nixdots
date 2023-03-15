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
        opacity = 1;
        padding = let
          value = 32;
        in {
          x = value;
          y = value;
        };
      };
      font =
        setfont "monospace"
        // {
          size = 13;
        }
        // {
          offset.y = 4;
          glyph_offset.y = 2;
        };
      cursor = {
        thickness = 0.1;
        style = {
          shape = "Beam";
          blinking = "on";
        };
      };
    };
  };
}
