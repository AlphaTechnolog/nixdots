{nur, pkgs}: {
  imports = [
    (import ./firefox.nix { inherit nur pkgs; })
    ./global.nix
    ./vscode.nix
    ./rofi.nix
    ./kitty.nix
    ./picom.nix
    ./neovim.nix
    ./starship.nix
    ./xdg.nix
  ];
}
