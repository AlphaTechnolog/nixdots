{ config, pkgs, ... }:

let
  run = import ./bin/run.nix { inherit pkgs; };
  decay-vscode = import ./programs/vscode-extensions.nix { inherit pkgs; };
  nfonts = import ./fonts/nerdfonts.nix { inherit pkgs; };
in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "alpha";
  home.homeDirectory = "/home/alpha";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # font-config
  fonts.fontconfig.enable = true;

  # some packages
  programs.rofi.enable = true;
  programs.firefox.enable = true;

  # services
  services.playerctld.enable = true;

  # gtk configuration
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-decoration-layout = "menu:";
    };
    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
    theme = {
      name = "Decayce";
    };
  };

  # editor (nvim)
  systemd.user.sessionVariables = { EDITOR = "nvim"; };

  # make it nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      sha256 = "1g483870cq1y6s1ibc1p4g58bq8c30jcqn6ymzpj0s3b3dsisbm7";
    }))
  ];

  # bat (cat clone)
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "plain";
      theme = "base16";
    };
  };

  # terminal (kitty)
  programs.kitty = {
    enable = true;
    extraConfig = import ./programs/kitty-theme.nix;
    settings = {
      window_padding_width = 30;
      confirm_os_window_close = 0;
      cursor_shape = "beam";
      cursor_beam_thickness = "0.5";
    };
    font = {
      size = 10;
      name = "BlexMono Nerd Font";
      package = (pkgs.nerdfonts.override {
        fonts = ["IBMPlexMono"];
      });
    };
  };

  # enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # cursor
  home.file = with pkgs; {
    ".icons/default".source = "${phinger-cursors}/share/icons/phinger-cursors";
  };

  # import more packages to home-manager ones.
  home.packages = with pkgs; [
  	xclip
    discord
    spotify
    exa
    gcc
    gh
    python3
    git
    obs-studio
    vlc
    postman
    mongodb-compass
    picom
    maim
    xfce.thunar
    neovim-nightly
    dconf
    decay-vscode
    run # my own script :)
    nfonts
  ];

  # shell
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "exa --icons";
      la = "ls -la";
      tree = "exa --tree";
      vim = "nvim";
      vi = "nvim";
      cat = "bat";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # shell prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "[ ](fg:blue)[|](fg:black) ";
    };
  };

  # import configuration files
  xdg.configFile.awesome.source = ./cfg/awesome;
  xdg.configFile.rofi.source = ./cfg/rofi;
  xdg.configFile.nvim.source = ./cfg/nvim;
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;
}
