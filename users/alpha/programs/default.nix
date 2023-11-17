{ pkgs }: {
  imports = [
    ./alacritty.nix
    ./global.nix
    ./neovim.nix
    ./starship.nix
    ./xdg.nix
    ./picom.nix
    ./rofi.nix
    ./vscode.nix
    ./discord.nix
  ];
}
