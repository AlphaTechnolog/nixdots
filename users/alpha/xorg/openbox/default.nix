{scheme, pkgs}: {
  imports = [
    (import ./theme.nix {inherit scheme;})
    (import ./autostart.nix {inherit pkgs;})
    (import ./configuration.nix {inherit pkgs;})
    (import ./bar.nix {inherit pkgs scheme;})
  ];
}