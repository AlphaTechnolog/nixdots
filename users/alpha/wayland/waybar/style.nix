let
  colors = import ../../theme/colors.nix {};
in with colors; ''
* {
  min-height: 0;
  border: none;
  border-radius: 0;
}

window#waybar {
  background: ${bg};
  color: ${fg};
  font-family: BlexMono NF;
  margin: 15px;
}

#custom-launcher {
  all: initial;
  min-width: 0;
  margin: 5px 6px;
  font-size: 22px;
  background-color: ${blue};
  color: ${bg};
  padding: 0px 10px;
  border-radius: 6px;
}

#workspaces button {
  all: initial;
  min-width: 0;
  box-shadow: inset 0 -3px transparent;
  border-radius: 4px;
  font-size: 22px;
  color: ${fg};
  font-family: BlexMono NF;
  padding: 0px 5px;
  margin: 4px 6px;
  border-bottom: solid 1px ${bg};
}

#workspaces button.active {
  color: ${magenta};
  border-bottom: solid 1px ${magenta};
  border-bottom-left-radius: 0px;
  border-bottom-right-radius: 0px;
}

#workspaces button.urgent {
  color: ${red};
}

#network {
  margin: 6px 6px;
  padding: 0px 14px;
  color: ${bg};
  background: ${magenta};
  font-size: 13px;
  border-radius: 6px;
  font-family: BlexMono Nerd Font;
}

#pulseaudio {
  color: ${blue};
  font-size: 13px;
  font-family: BlexMono Nerd Font;
  margin: 0 12px;
}

#backlight {
  color: ${yellow};
  font-size: 13px;
  font-family: BlexMono Nerd Font;
  margin-right: 12px;
}

#tray {
  margin: 0px 12px;
}

#clock {
  margin: 6px 6px;
  padding: 0px 10px;
  color: ${bg};
  background: ${green};
  font-size: 13px;
  border-radius: 6px;
  font-family: BlexMono Nerd Font;
}
''
