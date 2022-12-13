{ pkgs, colors, ... }:

let
  setfont = import ./setfont.nix {};
  theme = import ./theming.nix { inherit colors; };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = theme;
      mouse.hide_when_typing = true;
      window = {
        padding.x = 20;
        padding.y = 20;
        dynamic_padding = true;
      };
      font = setfont "JetBrainsMono Nerd Font" // {
        size = 8;
        offset.y = 4;
        glyph_offset.y = 2;
      };
      cursor = {
        thickness = 0.3;
        style = {
          shape = "Block";
          blinking = "on";
        };
      };
    };
  };
}
