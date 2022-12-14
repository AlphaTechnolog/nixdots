{ config, pkgs, lib, ... }:

let
  run = import ./bin/run.nix { inherit pkgs; };
  decayce-gtk = with pkgs; callPackage ../../pkgs/decayce-gtk.nix { };
  monaco-nf = with pkgs; callPackage ../../pkgs/monaco-nf.nix { };
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
  xdg.configFile."BetterDiscord/themes".source = ./cfg/bd-themes;

  # enable awesomewm
  home.activation.installAwesomeWMConfig = ''
    if [ ! -d "$HOME/.config/awesome" ]; then
      ln -s "/etc/nixos/users/$USER/cfg/awesome" "$HOME/.config/awesome"
      chmod -R +w "$HOME/.config/awesome"
    fi
  '';

  # xresources
  xresources.extraConfig = ''
    Xcursor.size: 24
    Xft.dpi: 76
  '';

  theme.base16.colors = base16-theme;

  imports = lib.attrValues nur.repos.rycee.hmModules ++ [
    (import ./programs/wezterm { inherit builtins; })
    (import ./programs/kitty { inherit pkgs; })
    (import ./programs/alacritty { inherit pkgs colors; })
    (import ./programs/firefox { inherit pkgs config nur colors; })
    (import ./programs/vscode { inherit pkgs config; })
    (import ./programs/picom.nix {})
    (import ./programs/rofi.nix { inherit pkgs config; })
    (import ./programs/starship.nix)
    (import ./programs/fish.nix)
    (import ./theme/nvim { inherit colors; })
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # font-config
  fonts.fontconfig.enable = true;

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

  # headset buttons
  systemd.user.services.mpris-proxy = {
    Unit.Description = "Mpris proxy";
    Unit.After = [ "network.target" "sound.target" ];
    Service.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    Install.WantedBy = [ "default.target" ];
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

  # cursor
  home.file = extra-fonts // {
    ".icons/default".source = "${pkgs.phinger-cursors}/share/icons/phinger-cursors";
  };

  # add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # cursor size (again) through sessionVariables
  home.sessionVariables = {
    GTK_THEME = "decayce";
    XCURSOR_SIZE = "24";
  };

  # import more packages to home-manager ones.
  home.packages = with pkgs; [
    gimp
    xclip
    discord
    libcanberra-gtk3
    pamixer
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
    neovide
    postman
    notion-app-enhanced
    maim
    jq
    networkmanagerapplet
    xfce.thunar
    neovim-nightly
    dconf
    nfonts
    monaco-nf
    tdesktop
    redshift
    cinnamon.nemo
    inotify-tools
    wirelesstools
    decayce-gtk # gtk theme :P
    run # my own script :)
  ];
}
