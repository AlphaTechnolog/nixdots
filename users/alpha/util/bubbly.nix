{pkgs}: {
  home.packages = [pkgs.bubbly];
  home.file.".local/share/bubbly".source = "${pkgs.bubbly}/share/bubbly";
  xdg.configFile."bubbly/config".text = ''
    keystrokes_bg=lavender
    keystrokes_limit=4
  '';
}
