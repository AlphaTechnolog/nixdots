{
  name = "rustic-decay";
  description = "The rustic variant for the decay colorscheme";
  colors = rec {
    primary = {
      background = "#131010";
      foreground = "#c2c2d6";
    };
    normal = {
      black = "#352e2e";
      red = "#be6875";
      green = "#97b982";
      yellow = "#d1bc71";
      blue = "#8499e0";
      purple = "#7b71bf";
      magenta = "#a984e0";
      cyan = "#8abae3";
      white = "#b5b5cd";
    };
    bright = normal // {
      black = "#423939";
    };
  };
}