{ colors }:

with colors; rec {
  primary = {
    background = bg;
    foreground = fg;
  };

  cursor = {
    text = bg;
    cursor = blue;
  };

  selection = {
    text = bg;
    background = fg;
  };

  normal = {
    black = black;
    red = red;
    green = green;
    yellow = yellow;
    blue = blue;
    magenta = magenta;
    cyan = cyan;
    white = white;
  };

  bright = {
    black = black;
    red = red;
    green = green;
    yellow = yellow;
    blue = blue;
    magenta = magenta;
    cyan = cyan;
    white = white;
  };

  dim = {
    black = black;
    red = red;
    green = green;
    yellow = yellow;
    blue = blue;
    magenta = magenta;
    cyan = cyan;
    white = white;
  };
}