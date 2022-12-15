let
  colors = import ../../theme/colors.nix {};
in with colors; ''
window#waybar {
  background: ${bg};
  color: ${fg};
}

#custom-launcher {
  border-radius: 4px;
  color: ${bg};
  background: ${blue};
  margin: 6px;
  font-family: BlexMono NF;
  font-size: 22px;
}

#workspaces {
  font-family: BlexMono Nerd Font Mono;
  font-size: 24px;
}

#workspaces button {
  all: unset;
  border-radius: 4px;
  transition: all ease 0.6s;
  margin: 2px 6px;
}

#workspaces button:hover {
  background: ${dimblack};
}

#workspaces button.active {
  color: ${magenta};
  background: ${black};
  border-left: solid 1px ${magenta};
  border-top-left-radius: 0px;
  border-bottom-left-radius: 0px;
}

#keyboard-state {
  font-family: BlexMono Nerd Font;
  font-size: 14px;
  padding-right: 6px;
  color: ${yellow};
}

#custom-settings {
  all: unset;
  font-family: BlexMono Nerd Font Mono;
  font-size: 20px;
  margin: 6px 6px 0px 6px;
  padding: 0px 2px 0px 0px;
  color: ${fg};
  background-color: ${black};
  border-radius: 4px;
}

#pulseaudio {
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
  font-size: 26px;
  font-family: BlexMono NF;
  color: ${cyan};
  background-color: ${black};
  margin: 6px 6px 0px 6px;
}

#network {
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  font-size: 14px;
  font-family: BlexMono Nerd Font;
  padding: 4px 7px 6px 0px;
  color: ${green};
  background-color: ${black};
  margin: 0px 6px 6px 6px;
}

#custom-hour {
  margin: 0px 6px;
  padding-top: 4px;
  font-family: BlexMono Nerd Font;
  font-size: 13px;
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
  background-color: ${black};
  color: ${fg};
}

#custom-mins {
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  background-color: ${black};
  color: ${fg};
  padding: 4px 0px;
  margin-bottom: 4px;
  font-family: BlexMono Nerd Font;
  font-size: 13px;
  margin-left: 6px;
  margin-right: 6px;
}

#custom-powermenu {
  all: unset;
  font-family: BlexMono Nerd Font Mono;
  font-size: 20px;
  margin: 0px 6px 4px;
  color: ${red};
  border-radius: 4px;
  background-color: ${black};
}
''
