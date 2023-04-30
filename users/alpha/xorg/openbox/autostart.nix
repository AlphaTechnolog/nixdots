{pkgs}: {
  xdg.configFile."openbox/autostart".source = let
    script = pkgs.writeScriptBin "openbox-autostart" ''
      #!${pkgs.bash}/bin/bash
      ${pkgs.feh}/bin/feh --bg-scale ${./wallpaper.png}
      xrdb merge $HOME/.Xresources
      pgrep -x picom || picom -b # it will inherit picom configuration.
    '';
  in "${script}/bin/openbox-autostart";
}
