{ pkgs, ... }: let
  theme = (import ../../../meta/theme.nix);
in {
  programs.alacritty = {
    enable = true;
    settings = let
      font-name = "monospace";
      size = 4;
    in {
      window = let
        padding = 6;
      in {
        padding.x = padding;
        padding.y = padding;
      };
      inherit (theme) colors;
      font = {
        inherit size;
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
