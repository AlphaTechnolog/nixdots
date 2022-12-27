{ src, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "sfmono-nf";
  version = "dev";
  inherit src;

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/*.otf $out/share/fonts
  '';

  meta.description = "Monaco font but patched with the nerd fonts tool!";
}