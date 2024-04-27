{ config, lib, pkgs, ... }:

let
  files = ./vhost-dev;
in
{
  imports = [
    (pkgs.path + "/nixos/modules/installer/cd-dvd/iso-image.nix")
  ];

  system.build.isoImage = lib.overrideDerivation config.system.build.isoImage (iso: {
    extraFiles = iso.extraFiles // {
      "config" = {
        source = files;
        target = "config";
        recursive = true;
      };
    };
  });
}
