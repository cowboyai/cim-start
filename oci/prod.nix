{ localFlake, withSystem }:
{ lib, config, ... }: {
  {
  options = {
    services.foo = {
      package = mkOption {
        default = withSystem ({ config, ... }: config.packages.default);
        defaultText = lib.literalMD "`packages.default` from the foo flake";
      };
    };
  };
  config = ... use localFlake ...;
}
