{
  network.description = "CIM-Dev via nixos-anywhere";

  dev = 
    { config, pkgs, ... }:
    {
      deployment.targetHost = "192.168.100.2";
      deployment.targetEnv = "libvirtd";
      deployment.libvirtd = {
        headless = true;
        memorySize = 16384;
        vcpu = 4;
      };

      programs.git.enable = true; 
      programs.zsh.enable = true;
      imports = [./dev/configuration.nix];
    };

  dns =
    { config, pkgs, ... }:
    {
      deployment.targetHost = "192.168.100.2";
      deployment.targetEnv = "libvirtd";
      deployment.libvirtd = {
        headless = true;
        memorySize = 2048;
        vcpu = 1;
      };
      imports = [./dns/configuration.nix];
    };

  nats =
    { config, pkgs, ... }:
    {
      deployment.targetHost = "192.168.100.2";
      deployment.targetEnv = "libvirtd";
      deployment.libvirtd = {
        headless = true;
        memorySize = 2048;
        vcpu = 2;
      };
      imports = [./nats/configuration.nix];
    };
}
