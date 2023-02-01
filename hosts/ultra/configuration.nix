{ config, pkgs, lib, ... }:

let
  virtualisation-packages = import ./virtualisation/pkgs.nix { inherit pkgs; };
  material-symbols = pkgs.callPackage ../../pkgs/material-symbols.nix {};
in {
  # imports some modules.
  imports = [
    ./hardware-configuration.nix
    ./virtualisation
  ];

  # use grub with os-prober support
  boot.loader = {
    systemd-boot.enable = false;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
  };

  security.sudo.enable = true;

  security.doas = {
    enable = true;
    extraRules = [
      {
        users = ["alpha"];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  # unstable kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # bash
  programs.bash = {
    promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';
  };

  networking.hostName = "ultra";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" ];

  # Set your time zone.
  time.timeZone = "America/Caracas";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  services.xserver.dpi = 86;

  # enables blueman for bluetooth
  services.blueman.enable = true;

  # gnome keyring and glib-networking
  services.gnome = {
    glib-networking.enable = true;
    gnome-keyring.enable = true;
  };

  # dbus
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr];
  };

  # gdm
  services.xserver.displayManager.gdm.enable = true;

  # AwesomeWM
  services.xserver.windowManager.awesome = {
    enable = true;
    luaModules = lib.attrValues {
      inherit (pkgs.luaPackages)
        lgi
        ldbus
        luadbi-mysql
        luaposix;
    };
  };

  # automount usb
  services.devmon.enable = true;
  services.udisks2.enable = true;

  # Configure keymap in X11
  services.xserver.layout = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # upower
  services.upower.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # docker
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alpha = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "libvirtd" "video" "audio" "input" ];
    initialPassword = "alpha123.";
  };

  # shell (fish)
  users.defaultUserShell = pkgs.fish;

  # light
  programs.light.enable = true;

  # packages
  environment.systemPackages = virtualisation-packages ++ (with pkgs; [
    wget
    git
    playerctl
    docker-compose
    cargo
    rustc
    protonvpn-cli

    # utils
    xorg.xwininfo
    xorg.xbacklight
    xorg.xinit
    brightnessctl
    chromedriver
    geckodriver
    selenium-server-standalone

    # wine
    wineWowPackages.stable
    (wine.override { wineBuild = "wine64"; })
    winetricks
  ]);

  # fontconfig configuration
  fonts = {
    fonts = with pkgs; [
      inter
      sf-mono-liga-bin
      phosphor-icons
      material-symbols
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
        monospace = ["Liga SFMono Nerd Font"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };

  # nixos version. don't change without caution.
  system.stateVersion = "22.05";

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # allow unfree pkgs through configuration.nix
  nixpkgs.config.allowUnfree = true;

  # enables opengl
  hardware.opengl.enable = true;
}