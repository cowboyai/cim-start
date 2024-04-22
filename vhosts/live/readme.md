# Using a Live Boot Image with NixOS-Anywhere
This allows a pretty simple way to achieve our installation if you have a network available.

1.  Download a live image
2.  copy it to usb
3.  boot
4.  ip addr (to obtain the dhcp addr)
5.  nix run github:nix-community/nixos-anywhere -- --flake '.#cim-vhost' nixos@