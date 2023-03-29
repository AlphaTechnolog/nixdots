{
  lib,
  stdenv,
  pkgs,
  src,
  ...
}:
stdenv.mkDerivation rec {
  pname = "decayce-gtk";
  version = "dev";

  inherit src;

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r ./Themes/Decayce $out/share/themes
  '';

  meta = {
    description = "Revamped GTK Theme for decay (Decayce Variant)";
    homepage = "https://github.com/decaycs/decay-gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.decaycs];
  };
}
