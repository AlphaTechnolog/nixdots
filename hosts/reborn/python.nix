{pkgs}: {
  environment.systemPackages = with pkgs; let
    material-color-utilities = pkgs.callPackage ../../derivs/material-color-utilities.nix {};
    python = python3.withPackages (p:
      with p; [
        numpy
        matplotlib
        black
        pandas
        scipy
        pygobject3
        material-color-utilities
      ]);
  in [
    python
    gobject-introspection
    pipenv
  ];
}