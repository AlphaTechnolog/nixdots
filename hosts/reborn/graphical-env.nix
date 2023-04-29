{ pkgs, lib, ... }: {
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager = {
      gnome.enable = true;
      xfce.enable = true;
    };
    windowManager.awesome = {
      enable = true;
      luaModules = lib.attrValues {
        inherit (pkgs.luaPackages)
          lgi
          ldbus
          luadbi-mysql
          luaposix;
      };
    };
  };
}
