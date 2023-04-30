{pkgs, scheme}: {
  services.polybar = let
    dimmed = "2a2a2a";
  in {
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
          font = 4;
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
      "module/playerctl" = let
        fetchSong = pkgs.writeScriptBin "fetch-song" ''
          #!${pkgs.bash}/bin/bash
          output="$(${pkgs.playerctl}/bin/playerctl metadata --format '{{title}}' 2>&1)"
          if [[ "$output" == "No players found" ]]; then
            exit 1 # it will hide its content on polybar
          fi

          echo "$output"
        '';
      in {
        type = "custom/script";
        exec = "${fetchSong}/bin/fetch-song";
        interval = 2;
        label = let
          limit = 25;
          output = "%output:0:${builtins.toString limit}:...%";
        in {
          text = "Listening to ${output}";
          fail = "";
        };
        format = {
          background = "#${base00}";
          foreground = "#${base06}";
          font = 7; # small afffff
        };
      };
      "module/powermenu-left" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base01}";
          background = "#${base00}";
        };
      };
      "module/powermenu-button" = {
        type = "custom/text";
        content = {
          text = "";
          font = 3;
          foreground = "#${base08}";
          background = "#${base01}";
        };
      };
      "module/powermenu-right" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base01}";
          background = "#${base00}";
        };
      };
      "module/space" = {
        type = "custom/text";
        content = " ";
      };
      "module/date" = {
        type = "internal/date";
        date = "%I:%M %p %a %d";
        format = "<label>";
        label-font = 4;
      };
      "module/meta-info-prefix" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base02}";
          background = "#${base00}";
        };
      };
      "module/meta-info-sufix" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base02}";
          background = "#${base00}";
        };
      };
      "module/meta-space" = {
        type = "custom/text";
        content = {
          text = " ";
          background = "#${base02}";
          foreground = "#${base02}";
        };
      };
      "module/volume" = {
        type = "internal/pulseaudio";
        use-ui-max = false;
        interval = 3;
        ramp.volume = ["惡" "隸" "醴"];
        click.right = "${pkgs.pavucontrol}/bin/pavucontrol";
        label-muted = {
          text = "了";
          background = "#${base02}";
          foreground = "#${base06}";
          font = 5;
        };
        format.volume = {
          text = "<ramp-volume>";
          background = "#${base02}";
          foreground = "#${base06}";
          font = 5;
        };
      };
      "module/brightness" = {
        type = "internal/backlight";
        card = "intel_backlight";
        ramp = ["律" "輪"];
        format = {
          text = "<ramp>";
          background = "#${base02}";
          foreground = "#${base06}";
          font = 5;
        };
      };
      "module/battery" = let
        framerate = 750;
        icons = ["" "" "" "" ""];
        
        reverseList = list:
          let
            len = length list;
            revList = builtins.foldl' (acc: x: [x] ++ acc) [] list;
          in revList;
      in {
        type = "internal/battery";
        full-at = 99;
        low-at = 15;
        battery = "BAT0";
        adapter = "ADP1";
        ramp.capacity = icons;
        format = let
          background = "#${base02}";
          font = 5;
        in {
          charging = {
            inherit background font;
            text = "<animation-charging>";
          };
          discharging = {
            inherit background font;
            text = "<ramp-capacity>";
          };
          full = {
            inherit background font;
            text = "<ramp-capacity>";
          };
        };
        animation = {
          charging = {
            inherit framerate;
            text = icons;
          };
          discharging = {
            inherit framerate;
            text = reverseList icons;
          };
        };
      };
      "module/dashboard" = {
        type = "custom/text";
        content = {
          text = "飼";
          foreground = "#${base0D}";
          font = 6;
        };
      };
      "module/workspaces-start" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base01}";
          background = "#${base00}";
        };
      };
      "module/workspaces-space" = {
        type = "custom/text";
        content = {
          text = " ";
          background = "#${base01}";
        };
      };
      "module/workspaces-end" = {
        type = "custom/text";
        content = {
          text = "";
          font = 1;
          foreground = "#${base01}";
          background = "#${base00}";
        };
      };
      "module/workspaces" = {
        type = "internal/xworkspaces";
        pin-workspaces = true;
        enable-click = true;
        enable-scroll = false;
        format = {
          text = "<label-state>";
          font = 5;
          background = "#${base01}";
        };
        label = let
          ghost = " ";
          circle = " ";
          circle-dashed = " ";
        in {
          active = {
            text = ghost;
            foreground = "#${base0D}";
          };
          occupied = {
            text = circle;
            foreground = "#${base06}";
          };
          urgent = {
            text = circle-dashed;
            foreground = "#${base08}";
          };
          empty = {
            text = circle-dashed;
            foreground = "#${dimmed}";
          };
        };
      };
      "global/wm".margin.top = 5;
      "bar/main" = {
        bottom = true;
        width = "80%";
        height = 30;
        background = "#${base00}";
        foreground = "#${base06}";
        offset = {
          x = "10%";
          y = 5;
        };
        border = {
          size = 10;
          color = "#${base00}";
        };
        modules = let
          launcher = "launcher-start launcher-icon launcher-sep launcher-label launcher-ending space";
          playerctl = "playerctl";
          dashboard = "dashboard space";
          workspaces = "workspaces-start workspaces-space workspaces workspaces-end";
          control = "meta-info-prefix battery meta-space volume meta-space brightness meta-info-sufix";
          date = "space date space";
          powermenu = "powermenu-left powermenu-button powermenu-right";
        in {
          left = "${launcher} ${playerctl}";
          center = "${dashboard} ${workspaces}";
          right = "${control} ${date} ${powermenu}";
        };
        font = [
          "Maple Mono NF:size=17;4"
          "Maple Mono NF:size=20;4"
          "Maple Mono NF:size=19;4"
          "Inter:size=11;2"
          "Phosphor:size=13;4"
          "Phosphor:size=24;7"
          "Inter:size=10;2"
        ];
      };
    };
  };
}
