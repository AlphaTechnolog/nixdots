# just some building tools, nothing special tho
# as this file just serves to install system pkgs
# which shares between hosts. So installing
# some essential build tools across every host

{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    gpp
  ];
}
