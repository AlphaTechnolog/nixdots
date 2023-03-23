{pkgs, ...}: {
  environment.systemPackages = with pkgs; let
    python = python3.withPackages (p:
      with p; [
        numpy
        matplotlib
        black
        pandas
        scipy
        pygobject3
      ]);
  in [
    python
    gobject-introspection
    pipenv
  ];
}
