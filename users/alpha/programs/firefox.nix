{nur}: {
  programs.firefox = {
    enable = true;
    profiles.alpha = {
      id = 0;
      settings."general.smoothScroll" = true;
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