{
  services.polybar = {
    enable = true;
    settings = let
      colors = import ../theme/colors.nix {};
    in
      with colors; {
        "bar/main" = {
          background = bg;
          foreground = fg;
          width = "100%";
          height = "36px";
          modules-center = "hello";
          font-0 = "monospace:size=10;2";
        };
        "module/hello" = {
          type = "custom/text";
          content = {
            text = "hello, world";
            foreground = fg;
          };
        };
      };
    script = ''
      polybar main &
    '';
  };
}
