{ pkgs }:

let
  brightnessctl = pkgs.brightnessctl + "/bin/brightnessctl";
  pamixer = pkgs.pamixer + "/bin/pamixer";
in {
  mainBar = {
    layer = "top";
    position = "top";
    height = 34;
    modules-left = ["custom/launcher" "wlr/workspaces"];
    modules-right = ["network" "pulseaudio" "backlight" "clock" "tray"];
    "custom/launcher" = {
      format = "";
      on-click = "rofi -show drun";
      tooltip = false;
    };
    "wlr/workspaces" = {
      format = "{icon}";
      format-icons = {
        "1" = "";
        "2" = "亂";
        "3" = "";
        "4" = "";
        "5" = "";
        "6" = "";
      };
      on-click = "activate";
      all-outputs = true;
      disable-scroll = true;
    };
    tray = {
      icon-size = 18;
      spacing = 10;
    };
    network = {
      interface = "wlp1s0";
      format = "{ifname}";
      format-wifi = " {essid} ({signalStrength}%)";
      format-disconnected = "Disconnected";
      tooltip = false;
    };
    pulseaudio = {
      tooltip = false;
      format = " {volume}%";
      on-click = "${pamixer} --default-source -t";
      on-scroll-up = "${pamixer} --default-source -d 1";
      on-scroll-down = "${pamixer} --default-source -i 1";
    };
    backlight = {
      tooltip = false;
      format = " {percent}%";
      on-scroll-up = "${brightnessctl} s 1%-";
      on-scroll-down = "${brightnessctl} s +1%";
    };
    clock = {
      interval = 60;
      format = " {:%I:%M %p}";
    };
  };
}
