{
  config,
  pkgs,
  lib,
  ...
}: let
  run = import ./bin/run.nix {inherit pkgs;};
  monaco-nf = with pkgs; callPackage ../../pkgs/monaco-nf.nix {};

  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "08r5hk5lp88h0r4167w5cq8dqnjv892ygs9g3sw9y1dhdbf8pyln";
  }) {inherit pkgs;};

  colors = import ./theme/colors.nix {};
  base16-theme = import ./theme/base16.nix {};
in {
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

  # link some configuration files
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  # xresources
  xresources.extraConfig = ''
    Xcursor.size: 22
    Xft.dpi: 86
  '';

  theme.base16.colors = base16-theme;

  imports =
    lib.attrValues nur.repos.rycee.hmModules
    ++ [
      (import ./programs/alacritty {inherit pkgs colors;})
      (import ./programs/wezterm)
      (import ./programs/kitty {inherit pkgs colors;})
      (import ./programs/firefox {inherit pkgs config nur colors;})
      (import ./programs/vscode {inherit pkgs config;})
      (import ./programs/neovim.nix {inherit pkgs;})
      (import ./programs/rofi.nix {inherit pkgs config;})
      (import ./programs/starship.nix)
      (import ./programs/fish.nix {inherit pkgs;})
      (import ./programs/chromium.nix {inherit pkgs;})
      (import ./programs/brave.nix {inherit pkgs;})
      (import ./programs/avim.nix {inherit pkgs;})
      (import ./programs/office.nix {inherit pkgs;})
      (import ./programs/wallset.nix {inherit pkgs;})
      (import ./programs/tmux {inherit pkgs;})
      (import ./programs/picom.nix {})
      (import ./programs/nix-index.nix)
      (import ./programs/go.nix)

      (import ./system/gtk.nix {inherit pkgs;})
      (import ./system/fonts {inherit pkgs;})

      (import ./util/bubbly.nix {inherit pkgs;})

      (import ./setup/hyprland {inherit pkgs;})
      (import ./setup/awesomewm.nix)
      (import ./setup/i3.nix {inherit pkgs lib;})
    ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # font-config
  fonts.fontconfig.enable = true;

  # services
  services.playerctld.enable = true;

  # editor (nvim)
  systemd.user.sessionVariables.EDITOR = "nvim";

  # headset buttons
  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = ["network.target" "sound.target"];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = ["default.target"];
  };

  # bat (cat clone)
  programs.bat = {
    enable = true;
    config = {
      paging = "never";
      style = "plain";
      theme = "base16";
    };
  };

  # enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # import more packages to home-manager ones.
  home.packages = with pkgs; [
    rxfetch-bin
    pre-commit
    stylua
    gimp
    xclip
    discord
    libcanberra-gtk3
    pamixer
    spotify
    exa
    gnome.zenity
    gcc
    gh
    ripgrep
    obs-studio
    vlc
    postman
    notion-app-enhanced
    maim
    mongodb-compass
    jq
    networkmanagerapplet
    lm_sensors
    xfce.thunar
    dconf
    monaco-nf
    patched-fonts
    tdesktop
    redshift
    cinnamon.nemo
    inotify-tools
    wirelesstools
    run # my own script :)
  ];
}
