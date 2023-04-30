{pkgs, scheme}: {
  services.polybar = {
    enable = true;
    script = ''
      polybar main &
    '';
    settings = with scheme.colors; {
      "module/launcher-start" = {
        type = "custom/text";
        click-left = "${pkgs.rofi}/bin/rofi -show drun";
        content = {
          text = "";
          font = 1;
          background = "#${base00}";
          foreground = "#${base0D}";
        };
      };
      "module/launcher-icon" = {
        type = "custom/text";
        click-left = "${pkgs.rofi}/bin/rofi -show drun";
        content = {
          text = "";
          font = 2;
          background = "#${base0D}";
          foreground = "#${base00}";
        };
      };
      "module/launcher-sep" = {
        type = "custom/text";
        click-left = "${pkgs.rofi}/bin/rofi -show drun";
        content = {
          text = "";
          font = 1;
          background = "#${base0D}";
          foreground = "#${base01}";
        };
      };
      "module/launcher-label" = {
        type = "custom/text";
        click-left = "${pkgs.rofi}/bin/rofi -show drun";
        content = {
          text = "  Applications ";
          font = 3;
          background = "#${base01}";
          foreground = "#${base06}";
        };
      };
      "module/launcher-ending" = {
        type = "custom/text";
        click-left = "${pkgs.rofi}/bin/rofi -show drun";
        content = {
          text = "";
          font = 1;
          foreground = "#${base01}";
          background = "#${base00}";
        };
      };
      "global/wm".margin.top = 5;
      "bar/main" = {
        bottom = true;
        width = "80%";
        offset-x = "10%";
        offset-y = 5;
        height = 30;
        background = "#${base00}";
        foreground = "#${base06}";
        border-size = 10;
        border-color = "#${base00}";
        modules-left = "launcher-start launcher-icon launcher-sep launcher-label launcher-ending";
        font-0 = "Maple Mono NF:size=17;4";
        font-1 = "Maple Mono NF:size=20;4";
        font-2 = "Inter:size=11;2";
      };
    };
  };
}
