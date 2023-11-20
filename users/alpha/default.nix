{ pkgs, ... }: {
  imports = [
    (import ./programs { inherit pkgs; })
    (import ./face.nix { inherit pkgs; })
    ./gtk.nix
    ./configuration.nix
    ./settings.nix
    ./shell.nix
  ];
}
