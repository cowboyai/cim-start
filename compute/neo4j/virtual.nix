{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 16384;
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your dev store.
      };
    };
  };

}
