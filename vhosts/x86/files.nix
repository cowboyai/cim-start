{
  config,
  lib,
  ...
}: let
  files = ./vhost-dev;
in {
  system.build.isoImage = lib.overrideDerivation config.system.build.isoImage (iso: {
    extraFiles =
      iso.extraFiles
      // {
        "conf" = {
          source = files;
          target = "conf";
          recursive = true;
        };
      };
  });
}
