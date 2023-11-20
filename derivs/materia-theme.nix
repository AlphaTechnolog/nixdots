{ stdenvNoCC, pkgs, src, lib, ... }: stdenvNoCC.mkDerivation rec {
  pname = "materia-theme";
  name = pname;
  version = "dev";
  inherit src;

  buildInputs = with pkgs; [
    meson
    dart-sass
    ninja
  ];

  dontConfigure = true;

  buildPhase = ''
    meson _build -Dprefix="$out" -Dcolors=default,dark -Dsizes=default,compact
  '';

  installPhase = ''
    meson install -C _build
  '';

  meta = with lib; {
    description = "Gtk Theme Materia";
    homepage = https://github.com/nana-4/materia-theme;
  };
}
