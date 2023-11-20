{ stdenvNoCC, pkgs, lib, src, ... }: stdenvNoCC.mkDerivation rec {
  pname = "apple-cursor";
  name = pname;
  version = "dev";
  inherit src;

  buildInputs = let
    python = pkgs.python3.withPackages(ps: with ps; [
      clickgen
      attrs
    ]);
  in with pkgs; [
    yarn
    python
  ];

  buildPhase = ''
    yarn build
  '';

  installPhase = ''
    mkdir -pv $out/share/icons    
    cp -rvf ./themes/* $out/share/icons
  '';

  meta = with lib; {
    description = "Apple cursors for gtk";
    homepage = "https://github.com/ful1e5/apple_cursor";
  };
}
