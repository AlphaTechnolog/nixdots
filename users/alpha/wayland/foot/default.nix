{ pkgs, ... }:

let
  colors = import ../../theme/raw-colors.nix {};
in with colors; {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=9";
        dpi-aware = "no";
        resize-delay-ms = 0;
        pad = "30x30";
      };
      cursor = {
        color = "${bg} ${blue}";
      };
      colors = {
        foreground = fg;
        background = bg;
        regular0 = black;
        regular1 = red;
        regular2 = green;
        regular3 = yellow;
        regular4 = blue;
        regular5 = magenta;
        regular6 = cyan;
        regular7 = white;
        bright0 = light-black;
        bright1 = red;
        bright2 = green;
        bright3 = yellow;
        bright4 = blue;
        bright5 = magenta;
        bright6 = cyan;
        bright7 = white;
      };
    };
  };
}
