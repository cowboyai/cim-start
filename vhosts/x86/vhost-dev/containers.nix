{
  dev = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "leaf0";
    localAddress = "192.168.1.81/24";      
    bindMounts = {
      "/etc/resolv.conf" = {
        hostPath = "/etc/resolv.conf";
        isReadOnly = true;
      };
    };
    config = { config, pkgs, ... }: {
      imports = [ 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/dev/configuration.nix" 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/dev/virtual.nix"
      ];
    };
  };

  dns = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "leaf0";
    localAddress = "192.168.1.254/24";
    bindMounts = {
      "/etc/resolv.conf" = {
        hostPath = "/etc/resolv.conf";
        isReadOnly = true;
      };
    };
    config = { config, pkgs, ... }: {
      networking.firewall.allowedTCPPorts = [ 53 ];
      networking.firewall.allowedUDPPorts = [ 53 ];
      imports = [ 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/dns/configuration.nix" 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/dns/virtual.nix"
      ];
    };
  };

  nats = {
    autoStart = true;
    privateNetwork = true;
    hostBridge = "leaf0";
    localAddress = "192.168.1.2/24";
    bindMounts = {
      "/etc/resolv.conf" = {
        hostPath = "/etc/resolv.conf";
        isReadOnly = true;
      };
    };
    config = { config, pkgs, ... }: {
      imports = [ 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/nats/configuration.nix" 
        "/home/steele/git/thecowboyai/cim.thecowboy.ai/compute/nats/virtual.nix"
      ];
    };

    systemd.services.install = {
      description = "Initialize nats service";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "polkit.service"];
      requires = ["network-online.target"];
      path = ["/run/current-system/sw/"];
      script = ''
        cd /etc/nats

        wait $process_id

        echo 'nats is initialized.'
        
      '';
      environment =
        config.nix.envVars
        // {
          inherit (config.environment.sessionVariables) NIX_PATH;
          HOME = "/root";
        };
      serviceConfig = {
        Type = "oneshot";
      };
    };
  };
}
