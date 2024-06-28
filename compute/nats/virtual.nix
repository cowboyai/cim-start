{
  config,
  pkgs,
  ...
}: {
  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 64; # megs... 64 megs
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your object store for now... we move it to S3 later
      };
      # we can also mount volumes here
    };
  };
}
