{ pkgs }:

{
  # installs lunarvim pkgs
  home.packages = with pkgs; [
    lunarvim-src
    lunarvim-wrapper
    gnumake
  ];

  # installs lvim files
  home.file = with pkgs; {
    ".local/share/lunarvim/lvim".source = lunarvim-src;
    ".config/lvim/config.lua".source = ./config.lua;
    ".config/nvim/config.lua".source = ./config.lua;
  };
}
