{ pkgs, ... }: let
  theme = (import ../../../meta/theme.nix);
in {
  programs.alacritty = {
    enable = true;
    settings = let
      font-name = "monospace";
      size = 4.5;
    in {
      inherit (theme) colors;
      cursor.style = "Underline";
      window = let
        padding = 6;
      in {
        padding.x = padding;
        padding.y = padding;
      };
      font = rec {
        inherit size;
        offset.y = 4;
        glyph_offset.y = offset.y / 2;
        normal = {
          family = font-name;
          style = "bold";
        };
        bold = {
          family = font-name;
          style = "bold";
        };
        italic = {
          family = font-name;
          style = "bold italic";
        };
      };
    };
  };
}
