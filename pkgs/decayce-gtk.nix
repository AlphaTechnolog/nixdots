{
  lib,
  stdenv,
  fetchzip,
  pkgs,
  ...
}:
stdenv.mkDerivation rec {
  pname = "decayce-gtk";
  version = "0.1.0";

  src = fetchzip {
    url = "https://github.com/decaycs/decay-gtk/releases/download/v0.1.0/decayce.zip";
    sha256 = "LMh3bMvH3r5cxUvklXdDj3tIHbnDHqdWMfnSihcvkwk=";
    stripRoot = false;
  };

  propagatedUserEnvPkgs = with pkgs; [
    gnome.gnome-themes-extra
    gtk-engine-murrine
  ];

  installPhase = ''
    mkdir -p $out/share/themes/
    cp -r Decayce $out/share/themes
  '';

  meta = {
    description = "Revamped GTK Theme for decay (Decayce Variant)";
    homepage = "https://github.com/decaycs/decay-gtk";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.decaycs];
  };
}
