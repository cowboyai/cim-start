{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 16384;
        cores = 4;
        graphics = true;
        diskSize = 32768; #set this to however big you want your dev store.
      };
    };
  };
}
