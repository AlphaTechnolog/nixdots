{
  stdenv,
  pkgs,
  lib,
  src,
  makeDesktopItem,
  ...
}:
stdenv.mkDerivation rec {
  pname = "bubbly";
  name = pname;
  version = "1.0.0";

  inherit src;

  propagatedUserEnvPkgs = with pkgs; [
    eww
    dash
  ];

  installPhase = ''
    mkdir -p $out/{bin,share}
    mkdir -p $out/share/bubbly
    cp -r ./* $out/share/bubbly
    cp -r $out/share/bubbly/config $out/share
    ln -sf $out/share/bubbly/start.sh $out/bin/bubbly
    chmod +x $out/bin/bubbly
  '';

  patches = [
    ./patches/dash-fix.diff
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "Bubbly";
      exec = "bubbly %U";
      tryExec = pname;
      icon = "preferences-desktop-keyboard-shortcuts";
      desktopName = pname;
      comment = "Generate chat bubble like widgets on screen via keystrokes on linux";
    })
  ];

  meta = {
    description = "Generate chat bubble like widgets on screen via keystrokes on linux";
    homepage = "https://github.com/siduck/bubbly";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = with lib.maintainers; [siduck76];
  };
}
