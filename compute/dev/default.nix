{  dev = 
    { config, pkgs, nodes, ... }:
    { 
      modules = [
        ./configuration.nix
      ];

      deployment.targetEnv = "qemu";
      deployment.virtualbox.memorySize = 8192; # MB
    };
}