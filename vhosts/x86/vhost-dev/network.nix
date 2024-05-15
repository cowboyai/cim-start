{ config, lib, pkgs, ... }:
{
  networking = {

    defaultGateway = {
      address = "192.168.1.1";
      interface = "leaf0";
    };

    bridges = {
      leaf0 = {
        interfaces = [ "enp0s31f6" "vxlan-lan" ];
        addresses = [ { "192.168.1.100"; prefixLength = 24; } ];
      };
      leaf1 = {
        interfaces = [ "enp23s0f1" "vxlan-comms" ];
        ip4 = [ { address = "192.168.2.1"; prefixLength = 24; } ];
      };
      leaf2 = {
        interfaces = [ "enp23s0f0" "vxlan-internal" ];
        ip4 = [ { address = "192.168.3.1"; prefixLength = 24; } ];
      };
      leaf3 = {
        interfaces = [ "enp2s0" "vxlan-dmz" ];
        ip4 = [ { address = "192.168.4.1"; prefixLength = 24; } ];
      };
      leaf4 = {
        interfaces = [ "enp23s0f1" "vxlan-agents" ];
        ip4 = [ { address = "192.168.5.1"; prefixLength = 24; } ];
      };
      leaf5 = {
        interfaces = [ "enp23s0f0" "vxlan-mgmt" ];
        ip4 = [ { address = "192.168.6.1"; prefixLength = 24; } ];
      };
    };
  };

  systemd.network = {
    "10-vxlan-lan.network" = {
      matchConfig = { name = "vxlan-lan"; };
      networkConfig = {
        vxlan = {
          id = 41;
          dev = "enp0s31f6";
          dstport = 4789;
        };
      };
    };
    "10-vxlan-comms.network" = {
      matchConfig = { name = "vxlan-comms"; };
      networkConfig = {
        vxlan = {
          id = 42;
          dev = "enp23s0f1";
          dstport = 4789;
        };
      };
    };
    "10-vxlan-internal.network" = {
      matchConfig = { name = "vxlan-internal"; };
      networkConfig = {
        vxlan = {
          id = 43;
          dev = "enp23s0f0";
          dstport = 4789;
        };
      };
    };
    "10-vxlan-dmz.network" = {
      matchConfig = { name = "vxlan-dmz"; };
      networkConfig = {
        vxlan = {
          id = 44;
          dev = "enp2s0";
          dstport = 4789;
        };
      };
    };
    "10-vxlan-agents.network" = {
      matchConfig = { name = "vxlan-agents"; };
      networkConfig = {
        vxlan = {
          id = 45;
          dev = "enp23s0f1";
          dstport = 4789;
        };
      };
    };
    "10-vxlan-mgmt.network" = {
      matchConfig = { name = "vxlan-mgmt"; };
      networkConfig = {
        vxlan = {
          id = 46;
          dev = "enp23s0f0";
          dstport = 4789;
        };
      };
    };
  };
  # the network relies on time...
  time.timeZone = "America/Phoenix";
}
