# this file basically configures everything needed to get working
# a virtualization with virt-manager.

{ ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "alpha" ];
  programs.dconf.enable = true;
}
