{ lib, stdenv, src }:

stdenv.mkDerivation rec {
  pname = "cutefetch";
  name = pname;
  version = "dev";

  inherit src;

  dontConfigure = true;
  dontBuild = true;
  doCheck = false;

  buildPhase = ''
    make
  '';

  installPhase = ''
    make PREFIX=$out install
  '';

  meta = with lib; {
    description = "Simple C fetch";
    homepage = "https://github.com/alphatechnolog/cutefetch";
    license = licenses.unlicense;
  };
}