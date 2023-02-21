{
  config,
  pkgs,
  lib,
  ...
}: let
  virtualisation-packages = import ./virtualisation/pkgs.nix {inherit pkgs;};
  material-symbols = pkgs.callPackage ../../pkgs/material-symbols.nix {};
in {
  # imports some modules.
  imports = [
    ./hardware-configuration.nix
    ./virtualisation
  ];

  # enable starship inside bash interactive session (useful when using nix-shell).
  programs.bash.promptInit = ''
    eval "$(${pkgs.starship}/bin/starship init bash)"
  '';

  # boot configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest; # latest xanmod kernel
    # plymouth
    plymouth = {
      enable = true;
      theme = "breeze";
    };
    # configure grub with os-prober
    loader = {
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
        gfxmodeEfi = "1920x1080";
        theme = pkgs.fetchzip {
          url = "https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/hp.tar";
          hash = "sha256-dJcJWpZswYOVKoDB37GGMcZ43/FFc+gKZfDeN29tnBk=";
          stripRoot = false;
        };
      };
    };
  };

  # configure doas instead of sudo
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [
        {
          users = ["alpha"];
          keepEnv = true;
          persist = true;
        }
      ];
    };
  };

  # network configuration
  networking = {
    hostName = "ultra";
    networkmanager.enable = true;
    nameservers = ["8.8.8.8"]; # google dns works better in America/Caracas.
  };

  # Timezone.
  time.timeZone = "America/Caracas";

  # Services Configuration.
  services = {
    # X11 windowing system.
    xserver = {
      enable = true;
      videoDrivers = ["intel"];
      dpi = 86;
      layout = "us";
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      windowManager.awesome = {
        enable = true;
        luaModules = lib.attrValues {
          inherit
            (pkgs.luaPackages)
            lgi
            ldbus
            luadbi-mysql
            luaposix
            ;
        };
      };
    };

    # max journald space
    journald.extraConfig = ''
      SystemMaxUse=2G
    '';

    # enables blueman for bluetooth
    blueman.enable = true;

    # gnome keyring and glib-networking
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    # automount usb
    devmon.enable = true;
    udisks2.enable = true;

    # printing
    printing.enable = true;

    # upower
    upower.enable = true;
  };

  # enables sound
  sound.enable = true;

  # hardware configuration + pulseaudio {i've got problems using pipewire}
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  # enables docker cuz i wanna use it.
  virtualisation.docker.enable = true;

  # User account, i use alpha.
  users = {
    defaultUserShell = pkgs.fish;
    users.alpha = {
      isNormalUser = true;
      initialPassword = "alpha123."; # 123. LMAO
      extraGroups = [
        "wheel"
        "docker"
        "networkmanager"
        "libvirtd"
        "video"
        "audio"
        "input"
      ];
    };
  };

  # light
  programs.light.enable = true;

  # dconf
  programs.dconf.enable = true;

  # packages
  environment.systemPackages =
    virtualisation-packages
    ++ (with pkgs; [
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
      (wine.override {wineBuild = "wine64";})
      winetricks
    ]);

  # fontconfig configuration
  fonts = {
    fonts = with pkgs; [
      inter
      lato
      maple-mono
      maple-mono-NF
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
        monospace = ["Maple Mono NF"];
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
}
