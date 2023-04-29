{nur, pkgs}: {
  programs.firefox = {
    enable = true;
    profiles.alpha = let
      firefox-gnome-theme = pkgs.callPackage ../../../derivs/firefox-gnome-theme.nix {};
    in{
      id = 0;
      settings."general.smoothScroll" = true;
      userChrome = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "${firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';
      extraConfig = builtins.readFile "${firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
      extensions = with nur.repos.rycee.firefox-addons; [
        enhanced-github
        refined-github
        stylus
        vue-js-devtools
        react-devtools
        reduxdevtools
      ];
    };
  };
}