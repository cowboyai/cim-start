  { config, pkgs, ... }:
  {

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 4096; 
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your object store for now... we move it to S3 later
      };
    };
  };
}