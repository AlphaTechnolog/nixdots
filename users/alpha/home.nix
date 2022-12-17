{ config, pkgs, lib, ... }:

let
  run = import ./bin/run.nix { inherit pkgs; };
  decayce-gtk = with pkgs; callPackage ../../pkgs/decayce-gtk.nix { };
  vscode-custom = with pkgs; callPackage ./programs/vscode { inherit pkgs; };
  nfonts = import ./fonts/nerdfonts.nix { inherit pkgs; };

  # integrates nur within Home-Manager
  nur = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/master.tar.gz";
    sha256 = "0z6w28kcsd3q31mgk67a7izn6zl07scsc8xvw5c6i35mkx0qyl43";
  }) { inherit pkgs; };

  colors = import ./theme/colors.nix {};
  base16-theme = import ./theme/base16.nix {};

  extra-fonts = import ./fonts {};
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

  # link some configuration files
  xdg.configFile.awesome.source = ./cfg/awesome;
  xdg.configFile.rofi.source = ./cfg/rofi;
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  theme.base16.colors = base16-theme;

  imports = lib.attrValues nur.repos.rycee.hmModules ++ [
    (import ./programs/wezterm { inherit builtins; })
    (import ./programs/kitty { inherit pkgs; })
    (import ./programs/alacritty { inherit pkgs colors; })
    (import ./programs/firefox { inherit pkgs config nur colors; })
    (import ./theme/nvim { inherit colors; })
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # font-config
  fonts.fontconfig.enable = true;

  # rofi
  programs.rofi.enable = true;

  # services
  services.playerctld.enable = true;

  # gtk configuration
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    theme.name = "Decayce";
    iconTheme = with pkgs; {
      name = "Papirus-Dark";
      package = papirus-icon-theme;
    };
  };

  # editor (nvim)
  systemd.user.sessionVariables.EDITOR = "nvim";

  # make it nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
      sha256 = "1s119q4xngrdijh6nmv6s4mllljqdd6r6wivdn2ncpc0422159p7";
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
        { name = "olets/zsh-window-title"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };

  # shell prompt
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$cmd_duration$git_branch$git_status[ ](fg:blue)[|](fg:black) ";
      git_branch = {
        format = "via [$symbol$branch(:$remote_branch)]($style) ";
      };
    };
  };

  # enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # cursor
  home.file = extra-fonts // {
    ".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
  };

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # import more packages to home-manager ones.
  home.packages = with pkgs; [
    gimp
    xclip
    discord
    spotify
    exa
    gcc
    gh
    python3
    nodejs
    lua
    ripgrep
    obs-studio
    vlc
    postman
    mongodb-compass
    notion-app-enhanced
    picom
    maim
    networkmanagerapplet
    xfce.thunar
    neovim-nightly
    dconf
    vscode-custom
    nfonts
    tdesktop
    redshift
    wirelesstools
    decayce-gtk # gtk theme :P
    run # my own script :)
  ];
}
