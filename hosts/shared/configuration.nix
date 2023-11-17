{ hostname, pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  time.timeZone = "America/Caracas";
  system.stateVersion = "23.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  sound.enable = true;

  hardware = {
    bluetooth.enable = true;
    pulseaudio.enable = true;
    opengl.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    tmp = {
      useTmpfs = true;
      tmpfsSize = "95%";
    };
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "1360x768";
      };
    };
  };

  networking = {
    hostName = hostname;
    firewall.enable = false; # idcr
    networkmanager = {
      enable = true;
      insertNameservers = ["8.8.8.8"];
    };
  };

  users.users.alpha = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "video"];
    initialPassword = "alpha123.";
  };

  services = {
    devmon.enable = true;
    udisks2.enable = true;
    blueman.enable = true;
    printing.enable = true;
    upower.enable = true;

    xserver = {
      enable = true;
      layout = "us";
      libinput.enable = true;
    };

    journald.extraConfig = ''
      SystemMaxUse=2G
    '';

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };
  };
}
