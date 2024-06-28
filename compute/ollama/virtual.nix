{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 32768;
        cores = 2;
        graphics = false;
        diskSize = 65535; #set this to however big you want your dev store.
      };
    };
  };
}
