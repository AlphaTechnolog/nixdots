{ pkgs, ... }: {
  imports = [
    (import ./programs { inherit pkgs; })
    (import ./face.nix { inherit pkgs; })
    ./configuration.nix
    ./settings.nix
    ./shell.nix
  ];
}
