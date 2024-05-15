  { config, pkgs, ... }:
  {
    virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 8192;
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your dev store.
      };
    };
  };
}