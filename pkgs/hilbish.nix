{ lib, stdenv, fetchFromGitHub, buildGoModule, pkgs, ... }:

buildGoModule rec {
  pname = "hilbish";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "Rosettea";
    repo = "Hilbish";
    rev = "v${version}";
    sha256 = "sha256-887pKfPBmaNsGlla0oNBR3S6HVJvD4jr3M65dzJZIX0=";
    fetchSubmodules = true;
  };

  vendorSha256 = "sha256-Kiy1JR3X++naY2XNLpnGujrNQt7qlL0zxv8E96cHmHo=";

  subPackages = [ "." ];

  ldflags = [
    "-s" "-w"
    "-X main.dataDir=${placeholder "out"}/local/share/hilbish"
  ];

  postInstall = ''
    mkdir -p "$out/local/share/hilbish"
    cp .hilbishrc.lua $out/local/share/hilbish
    cp -r libs -t $out/local/share/hilbish
    cp -r docs -t $out/local/share/hilbish
    cp -r emmyLuaDocs -t $out/local/share/hilbish
    cp -r nature -t $out/local/share/hilbish
    cp -r .hilbishrc.lua -t $out/local/share/hilbish
  '';

  meta = {
    description = "Hilbish-Shell v2.0.0 - The flower shell.";
    homepage = "https://github.com/Rosettea/Hilbish";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    maintainers = [lib.maintainers.sammyette];
  };

  passthru.shellPath = "/bin/hilbish";
}
