{ pkgs, src, stdenvNoCC, ... }: stdenvNoCC.mkDerivation rec {
  pname = "sf-mono-liga-bin";
  name = pname;
  version = "dev";
  inherit src;
  dontConfigure = true;
  installPhase = ''
    mkdir -pv $out/share/fonts/opentype/
    cp -R $src/*.otf $out/share/fonts/opentype/
  '';
}
