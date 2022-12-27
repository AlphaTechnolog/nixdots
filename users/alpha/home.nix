{ config, pkgs, lib, ... }:

let
  run = import ./bin/run.nix { inherit pkgs; };
  decayce-gtk = with pkgs; callPackage ../../pkgs/decayce-gtk.nix { };
  monaco-nf = with pkgs; callPackage ../../pkgs/monaco-nf.nix { };
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
  xdg.configFile.hilbish.source = ./cfg/hilbish;
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  xresources.extraConfig = "Xft.dpi: 76";

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

  # picom
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;

    shadow = true;
    shadowOffsets = [(-12) (-12)];
    shadowOpacity = 0.6;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];

    fade = true;
    fadeDelta = 10;
    fadeSteps = [0.03 0.03];
    fadeExclude = [];

    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    menuOpacity = 1.0;
    opacityRules = ["70:class_g = 'splash'"];

    wintypes = {
      tooltip = {
        fade = true;
        shadow = true;
        focus = true;
        full-shadow = true;
      };
      dock = {
        shadow = true;
        clip-shadow-above = false;
        full-shadow = true;
      };
      dnd = {shadow = false;};
      popup_menu = {opacity = 1;};
      dropdown_menu = {opacity = 1;};
      desktop = {full-shadow = false;};
      normal = {full-shadow = false;};
    };

    settings = {
      shadow-radius = 12;
      shadow-color = "#000000";
      shadow-ignore-shaped = false;

      frame-opacity = 1.0;
      inactive-opacity-override = false;
      focus-exclude = [
        "class_g = 'Peek'"
        "class_g = 'Cairo-clock'"
      ];

      corner-radius = 10;
      rounded-corners-exclude = [];

      blur-method = "dual_kawase";
      blur-kernel = "11x11gaussian";
      blur-size = 12;
      blur-deviation = 1.0;
      blur-strength = 8;
      blur-background = false;
      blur-background-frame = true;
      blur-background-fixed = true;
      blur-background-exclude = [
        "class_g = 'slop'"
        "class_g = 'firefox'"
        "_GTK_FRAME_EXTENTS@:c"
        "window_type = 'desktop'"
        "window_type = 'menu'"
      ];

      mark-wmwin-focused = true;
      mark-ovredir-focused = true;
      detect-rounded-corners = true;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      glx-no-stencil = true;
      use-damage = true;
      transparent-clipping = false;
      log-level = "warn";
    };
  };

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
      sha256 = "0j8wihp65cjv3ayvxff8513kkw4994s44niz7apihp05qkyqscw2";
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

  # enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # cursor, extra fonts, hilbish plugins, etc
  home.file = extra-fonts // {
    ".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
    ".local/share/hilbish/libs/promptua".source = pkgs.fetchFromGitHub {
      owner = "TorchedSammy";
      repo = "Promptua";
      rev = "d0ab5202ed68a6dc1a959e7a69f8b45854a4dd40";
      sha256 = "gqfh7q8esp5S6hussOSKU1SmuDaoTdRK84ccM/Qzm/s=";
    };
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
    jq
    networkmanagerapplet
    xfce.thunar
    neovim-nightly
    dconf
    vscode-custom
    nfonts
    monaco-nf
    tdesktop
    redshift
    wirelesstools
    decayce-gtk # gtk theme :P
    run # my own script :)
  ];
}
