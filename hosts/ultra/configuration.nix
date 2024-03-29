# vim:tabstop=2 shiftwidth=2 expandtab
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

let
  virtualisation-packages = import ./virtualisation/pkgs.nix { inherit pkgs; };
  material-symbols = pkgs.callPackage ../../pkgs/material-symbols.nix {};
in {
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

  networking.hostName = "ultra"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.nameservers = [ "8.8.8.8" ];

  # Set your time zone.
  time.timeZone = "America/Caracas";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.dpi = 76;

  services.blueman.enable = true;

  services.gnome = {
    glib-networking.enable = true;
    gnome-keyring.enable = true;
  };

  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr];
  };

  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters.gtk.cursorTheme = {
      name = "Phinger Cursors";
      package = pkgs.phinger-cursors;
      size = 24;
    };
  };

  services.xserver.desktopManager.xfce.enable = true;

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
  # services.xserver.xkbOptions = {
  #   "eurosign:e";
  #   "caps:escape" # map caps to escape.
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # upower
  services.upower.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = false;

  # pipewire
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };

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

  # bluetooth pipewire
  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = virtualisation-packages ++ (with pkgs; [
    st
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
    brightnessctl
    pulseaudio # just its utils

    # wine
    wineWowPackages.stable
    (wine.override { wineBuild = "wine64"; })
    winetricks
  ]);

  fonts = {
    fonts = with pkgs; [
      inter
      sf-mono-liga-bin
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
        monospace = ["Monaco Nerd Font"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  # enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # allow unfree pkgs through configuration.nix
  nixpkgs.config.allowUnfree = true;

  hardware.opengl = {
    enable = true;
  };
}

