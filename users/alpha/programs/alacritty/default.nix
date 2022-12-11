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
        padding.x = 40;
        padding.y = 40;
        dynamic_padding = true;
      };
      font = setfont "JetBrainsMono Nerd Font" // {
        size = 8;
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
