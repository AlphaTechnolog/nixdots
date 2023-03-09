{colors}:
with colors; rec {
  primary = {
    background = bg;
    foreground = fg;
  };

  cursor = {
    text = bg;
    cursor = accent;
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
    blue = accent;
    magenta = magenta;
    cyan = blue;
    white = white;
  };

  bright = {
    black = black;
    red = red;
    green = green;
    yellow = yellow;
    blue = accent;
    magenta = magenta;
    cyan = blue;
    white = white;
  };

  dim = {
    black = black;
    red = red;
    green = green;
    yellow = yellow;
    blue = accent;
    magenta = magenta;
    cyan = blue;
    white = white;
  };
}
