{ pkgs, lib, ... }: {
  services.xserver = {
    displayManager.gdm.enable = true;
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
