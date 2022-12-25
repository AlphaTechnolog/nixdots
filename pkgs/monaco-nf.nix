{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "monaco-nerd-fonts";
  version = "1.0.0";
  src = fetchFromGitHub {
    owner = "Karmenzind";
    repo = "monaco-nerd-fonts";
    rev = "4c7fe33df56420b06e0a094db9c4d9a23333b1b7";
    sha256 = "W7+ovaWbbtuGvCgqe3ntWodjBMG9JuzdTM0BlnsGk5c=";
    fetchSubmodules = false;
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -R $src/fonts/*.ttf $out/share/fonts
  '';

  meta.description = "Monaco font but patched with the nerd fonts tool!";
}
