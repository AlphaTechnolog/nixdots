{ pkgs, colors, ... }:

let
  setfont = import ./setfont.nix {};
  theme = import ./theming.nix { inherit colors; };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding.x = 40;
        padding.y = 40;
        dynamic_padding = true;
      };
      font = setfont "BlexMono Nerd Font" // {
        size = 8;
      };
      colors = theme;
      cursor.style = {
        shape = "Block";
        blinking = "on";
      };
      mouse.hide_when_typing = true;
    };
  };
}
