{ config, lib, pkgs, modulesPath, ... }: {
  imports = let
    not-detected = modulesPath + "/installer/scan/not-detected.nix";
  in [not-detected];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot = {
    kernelModules = ["kvm-intel"];  
    extraModulePackages = [];
    initrd = {
      availableKernelModules = ["vmd" "xhci_pci" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
    };
    "/boot/efi" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };
  };

  swapDevices = let
    standard-size = 12 * 1024;
  in [
    {
      device = "/swapfile";
      size = standard-size;
    }
  ];
}
