{ pkgs }:

let
  pavucontrol = "${pkgs.pavucontrol}/bin/pavucontrol";
in {
  mainBar = {
    layer = "top";
    position = "left";
    width = 40;
    modules-left = ["custom/launcher" "wlr/workspaces"];
    modules-right = ["keyboard-state" "custom/settings" "pulseaudio" "network" "custom/hour" "custom/mins" "custom/powermenu"];
    "custom/launcher" = {
      format = "";
      on-click = "rofi -show drun";
      tooltip = false;
    };
    "wlr/workspaces" = {
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        "1" = "";
        "2" = "亂";
        "3" = "";
        "4" = "";
        "5" = "";
        "6" = "";
      };
    };
    keyboard-state = {
      tooltip = false;
      numlock = false;
      capslock = true;
      format.capslock = "{icon}";
      format-icons = {
        locked = "";
        unlocked = ""; # an empty string will disable the module
      };
    };
    "custom/settings" = {
      format = "";
      tooltip = false;
    };
    pulseaudio = {
      format = "{icon}";
      format-bluetooth = "{icon}";
      format-muted = "婢";
      on-click = "${pavucontrol}";
      format-icons = {
        headphone = "";
        default = ["" "" "墳" ""];
      };
    };
    network = {
      format-wifi = "";
      format-disconnected = "睊";
      tooltip = false;
    };
    "custom/hour" = {
      interval = 60;
      exec = "date '+%H'";
      tooltip = false;
    };
    "custom/mins" = {
      interval = 60;
      exec = "date '+%M'";
      tooltip = false;
    };
    "custom/powermenu" = {
      format = "襤";
      tooltip = false;
    };
  };
}
