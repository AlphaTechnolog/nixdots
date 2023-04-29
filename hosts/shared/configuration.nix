{ hostname, pkgs, ... }: {
  # loads the hardware configuration
  imports = [
    ./hardware-configuration.nix
  ];

  # timezone
  time.timeZone = "America/Caracas";

  # nix version, don't change without caution
  system.stateVersion = "22.11"; # read the comment before changing please

  # enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # sound
  sound.enable = true;

  # hardware configuration
  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  # booting configuration
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "i8042.dumbkbd"
    ];
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
      };
    };
  };

  # networking, loading hostname, disabling firewall and enabling
  # networkmanager which is the most easiest manager for the networks.
  networking = {
    hostName = hostname;
    firewall.enable = false; # ik security issues but i don't care
    networkmanager = {
      enable = true;
      insertNameservers = ["8.8.8.8"];
    };
  };

  # making the user with default dummy password.
  users.users.alpha = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    initialPassword = "alpha123.";
  };

  # some services.
  services = {
    # auto usb mounting
    devmon.enable = true;
    udisks2.enable = true;

    # blueman
    blueman.enable = true;

    # printing
    printing.enable = true;

    # battery
    upower.enable = true;

    # X server, graphical environments.
    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
    };

    # space issues solving.
    journald.extraConfig = ''
      SystemMaxUse=2G
    '';

    # gnome glib-networking and gnome-keyring
    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };
}

