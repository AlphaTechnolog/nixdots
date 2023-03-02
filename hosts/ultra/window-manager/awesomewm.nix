{
  lib,
  pkgs,
  ...
}: {
  services.xserver.windowManager.awesome = {
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
}
