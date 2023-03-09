{pkgs}: {
  home.packages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.es_ANY
  ];
}
