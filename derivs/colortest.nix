{ stdenvNoCC, ... }: stdenvNoCC.mkDerivation rec {
  pname = "colortest";
  name = pname;
  version = "custom";
  src = ../extras/colortest/.;
  dontConfigure = true;
  installPhase = ''
    mkdir -pv $out/bin
    install -Dvm755 ./colortest $out/bin
  '';
}