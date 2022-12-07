# this file basically configures everything needed to get working
# a virtualization with virt-manager.

{ ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
}
