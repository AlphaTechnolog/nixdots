{ pkgs, ... }: {
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
      colors = {
        primary = {
          background = "#0f0f0f";
          foreground = "#f0f0f0";
        };
        normal = {
          black = "#262626";
          red = "#ac8a8c";
          green = "#8aac8b";
          yellow = "#aca98a";
          blue = "#8f8aac";
          magenta = "#ac8aac";
          cyan = "#8aabac";
          white = "#e7e7e7";
          orange = "#c6a679";
        };
        bright = {
          black = "#4c4c4c";
          red = "#c49ea0";
          green = "#9ec49f";
          yellow = "#c4c19e";
          blue = "#a49ec4";
          magenta = "#c49ec4";
          cyan = "#9ec3c4";
          white = "#f5f5f5";
          orange = "#ceb188";
        };
      };
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
