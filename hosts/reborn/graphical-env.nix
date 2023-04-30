{ pkgs, lib, ... }: {
  services.xserver = {
    displayManager.gdm.enable = true;
    windowManager = {
      openbox.enable = true;
      awesome = {
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
  };
}
