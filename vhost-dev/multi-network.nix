{
  config,
  lib,
  pkgs,
  ...
}: {
  networking = {
    hostName = "vhost-dev";
    search = ["cim.thecowboy.ai"];

    networkmanager.enable = false;
    useDHCP = false;

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp0s31f6";
    };

    interfaces = {
      enp0s31f6 = {useDHCP = false;};
      enp2s0 = {useDHCP = false;};
      enp23s0f0 = {useDHCP = false;};
      enp23s0f1 = {useDHCP = false;};
    };

    bridges = {
      br-lan.interfaces = ["enp0s31f6"];
      br-dmz.interfaces = ["enp2s0"];
      br-comms.interfaces = ["enp23s0f0"];
      br-agents.interfaces = ["enp23s0f0"];
      br-internal.interfaces = ["enp23s0f1"];
      br-mgmt.interfaces = ["enp23s0f1"];
    };
  };

  systemd.network = {
    netdevs = {
      #vlans
      "10-vlan-lan.netdev" = {
        netdevConfig = {
          Name = "vlan-lan";
          Kind = "vlan";
        };
        vlanConfig = {Id = 1;};
      };
      "10-vlan-comms.netdev" = {
        netdevConfig = {
          Name = "vlan-comms";
          Kind = "vlan";
        };
        vlanConfig = {Id = 2;};
      };
      "10-vlan-internal.netdev" = {
        netdevConfig = {
          Name = "vlan-internal";
          Kind = "vlan";
        };
        vlanConfig = {Id = 3;};
      };
      "10-vlan-dmz.netdev" = {
        netdevConfig = {
          Name = "vlan-dmz";
          Kind = "vlan";
        };
        vlanConfig = {Id = 4;};
      };
      "10-vlan-agents.netdev" = {
        netdevConfig = {
          Name = "vlan-agents";
          Kind = "vlan";
        };
        vlanConfig = {Id = 5;};
      };
      "10-vlan-mgmt.netdev" = {
        netdevConfig = {
          Name = "vlan-mgmt";
          Kind = "vlan";
        };
        vlanConfig = {Id = 6;};
      };
    };

    networks = {
      #interfaces
      "15-enp0s31f6.network" = {
        matchConfig.name = "enp0s31f6";
        vlan = ["vlan-lan"];
      };
      "15-enp2s0.network" = {
        matchConfig.name = "enp2s0";
        vlan = ["vlan-dmz"];
      };
      "15-enp23s0f0.network" = {
        matchConfig.name = "enp23s0f0";
        vlan = ["vlan-comms" "vlan-agents"];
      };
      "15-enp23s0f1.network" = {
        matchConfig.name = "enp23s0f1";
        vlan = ["vlan-internal" "vlan-mgmt"];
      };

      #bridges aka leaves
      "20-br-lan.netdev" = {
        netdevConfig = {
          Name = "br-lan";
          Kind = "bridge";
        };
      };
      "20-br-dmz.netdev" = {
        netdevConfig = {
          Name = "br-dmz";
          Kind = "bridge";
        };
      };
      "20-br-comms.netdev" = {
        netdevConfig = {
          Name = "br-comms";
          Kind = "bridge";
        };
      };
      "20-br-agents.netdev" = {
        netdevConfig = {
          Name = "br-agents";
          Kind = "bridge";
        };
      };
      "20-br-internal.netdev" = {
        netdevConfig = {
          Name = "br-internal";
          Kind = "bridge";
        };
      };
      "20-br-mgmt.netdev" = {
        netdevConfig = {
          Name = "br-mgmt";
          Kind = "bridge";
        };
      };

      #networks
      "25-vlan-lan.network" = {
        matchConfig.name = "vlan-lan";
        networkConfig.bridge = "br-lan";
        networkConfig.address = "192.168.1.100/24";
      };
      "25-vlan-comms.network" = {
        matchConfig.name = "vlan-comms";
        networkConfig.bridge = "br-comms";
        networkConfig.address = "192.168.2.100/24";
        gateway = "192.168.1.1";
      };
      "25-vlan-internal.network" = {
        matchConfig.name = "vlan-internal";
        networkConfig.bridge = "br-internal";
        networkConfig.address = "192.168.3.100/24";
        gateway = "192.168.1.1";
      };
      "25-vlan-dmz.network" = {
        matchConfig.name = "vlan-dmz";
        networkConfig.bridge = "br-dmz";
        networkConfig.address = "192.168.4.100/24";
        gateway = "192.168.1.1";
      };
      "25-vlan-agents.network" = {
        matchConfig.name = "vlan-agents";
        networkConfig.bridge = "br-agents";
        networkConfig.address = "192.168.5.100/24";
        gateway = "192.168.1.1";
      };
      "25-vlan-mgmt.network" = {
        matchConfig.name = "vlan-mgmt";
        networkConfig.bridge = "br-mgmt";
        networkConfig.address = "192.168.6.100/24";
        gateway = "192.168.1.1";
      };
    };
  };

  # the network relies on time...
  time.timeZone = "America/Phoenix";
}
