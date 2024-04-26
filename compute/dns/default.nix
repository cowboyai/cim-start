{  dns = 
    { config, pkgs, nodes, ... }:
    { 
      modules = [
        ./configuration.nix
      ];

      deployment.targetEnv = "qemu";
      deployment.virtualbox.memorySize = 4096; # MB
    };
}