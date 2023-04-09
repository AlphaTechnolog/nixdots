{
  config,
  pkgs,
  nur,
  colors,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.alpha = {
      id = 0;

      settings."general.smoothScroll" = true;

      extensions = with nur.repos.rycee.firefox-addons; [
        enhanced-github
        enhancer-for-youtube
        refined-github
        stylus
        vue-js-devtools
        react-devtools
        reduxdevtools
      ];

      userChrome = ''
        @import "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userChrome.css";
      '';

      userContent = ''
        @import "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/userContent.css";
      '';

      extraConfig = builtins.readFile "${pkgs.firefox-gnome-theme}/share/firefox-gnome-theme/configuration/user.js";
    };
  };
}
