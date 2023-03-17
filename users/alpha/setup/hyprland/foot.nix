{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = let
      colors = import ../../theme/raw-colors.nix {};
    in
      with colors; {
        mouse.hide-when-typing = "yes";
        main = {
          font = "monospace:size=11";
          dpi-aware = "no";
          pad = "20x20";
        };
        csd = {
          preferred = "none";
        };
        cursor = {
          style = "Beam";
          blink = "yes";
          beam-thickness = 1;
        };
        colors = {
          background = bg;
          foreground = fg;
          regular0 = black;
          regular1 = red;
          regular2 = green;
          regular3 = yellow;
          regular4 = accent;
          regular5 = magenta;
          regular6 = blue;
          regular7 = white;
          bright0 = grey;
          bright1 = red;
          bright2 = green;
          bright3 = yellow;
          bright4 = accent;
          bright5 = magenta;
          bright6 = blue;
          bright7 = white;
        };
      };
  };
}
