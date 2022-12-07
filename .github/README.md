# nixdots

My personal dotfiles for a Nix-Managed Operative System (NixOS).

> X11 (AwesomeWM)

![x11](./assets/x11.png)

> Wayland (Hyprland)

![wayland](./assets/wayland.png)

## Installation

To install it see the next steps:

- Boot into the installer environment
- Format and mount your disks inside /mnt
- execute this

```sh
# go into a root shell
sudo su

# go inside a shell with properly required programs
nix-shell -p git nixUnstable

# create this folder if necessary
mkdir -p /mnt/etc/

# clone the repo
git clone https://github.com/AlphaTechnolog/nixfiles.git /mnt/etc/nixos.git --recurse-submodules

# remove this file
rm /mnt/etc/nixos/hosts/ultra/hardware-configuration.nix

# generate the config and take some files
nixos-generate-config --root /mnt
rm /mnt/etc/nixos/configuration.nix
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/ultra

# make sure you're in this path
cd /mnt/etc/nixos

# remove .git to avoid some issues with nixos-rebuild
rm -rf ./.git

# to install the xorg version:
nixos-install --flake '.#ultra' --impure

# to install the wayland version
nixos-install --flake '.#wayland' --impure
```

- Reboot, login as root, and change the password for your user using `passwd` (by default, it's alpha)
- Log-in in the displayManager.
- Then do this:

```sh
doas chown -R $USER /etc/nixos
```

## Enjoy

Now, you're done, remember that this is in work in progress so, some
things could stop working...

## Thanks to

This good people who helped me when learning nix-related stuff! really, thanks!

- [AloneER0](https://github.com/AloneER0)
- [JavaCafe01](https://github.com/JavaCafe01)
- [rxyhn](https://github.com/rxyhn)
