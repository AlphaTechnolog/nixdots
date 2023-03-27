{ stdenv, fetchFromGitHub, pkgs, src }:

stdenv.mkDerivation {
  name = "patched-fonts";

  inherit src;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/{camingo-code,operator-mono-nerd-font,sf-mono-nerd-font}/*.{ttf,otf} $out/share/fonts
  '';
}
