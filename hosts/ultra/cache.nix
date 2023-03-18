# switchs to beta cache
{...}: {
  nix.settings.substituters = [
    "https://aseipp-nix-cache.global.ssl.fastly.net"
  ];
}
