{ pkgs }: {
  fonts = {
    fonts = with pkgs; let
      phosphor-icons = pkgs.callPackage ../../derivs/phosphor.nix { inherit pkgs; };
    in [
      inter
      lato
      maple-mono
      maple-mono-NF
      phosphor-icons
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };
      subpixel.lcdfilter = "default";
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Maple Mono NF"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };
}