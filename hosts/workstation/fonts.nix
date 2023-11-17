{ pkgs, inputs, ... }: {
  fonts = {
    packages = let
      material-symbols = pkgs.callPackage ../../derivs/material-symbols.nix {}; 
      sf-mono-liga-bin = pkgs.callPackage ../../derivs/sfmono.nix {
        src = inputs.sf-mono-liga-src;
      };
    in with pkgs; [
      sf-mono-liga-bin
      material-symbols
      inter
      lato
      roboto
      maple-mono
      maple-mono-NF
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
        style = "full";
      };
      subpixel.lcdfilter = "default";
      defaultFonts = {
        emoji = ["Noto Color Emoji"];
        monospace = ["Liga SFMono Nerd Font"];
        sansSerif = ["Roboto" "Noto Sans" "Noto Color Emoji"];
        serif = ["Roboto" "Noto Serif" "Noto Color Emoji"];
      };
    };
  };
}
