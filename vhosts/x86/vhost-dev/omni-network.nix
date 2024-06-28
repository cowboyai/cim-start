{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    wpa_supplicant.enable = false;
  };

  networking = {
    hostName = "vhost-dev";
    search = ["cim.thecowboy.ai"];

    networkmanager.enable = false;
    wireless.enable = false;

    useDHCP = false;
    enableIPv6 = false;

    defaultGateway = {
      address = "192.168.1.1";
      interface = "br-lan";
    };
    nameservers = ["192.168.1.254" "1.1.1.1" "1.0.0.1"];

    bridges = {
      br-lan = {
        interfaces = ["enp0s31f6"];
      };
    };

    interfaces = {
      # sw1.p2
      # mac: 74:86:e2:10:a1:fa
      enp0s31f6 = {
        useDHCP = false;
      };
      br-lan = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "192.168.1.100";
            prefixLength = 24;
          }
        ];
      };
      # sw2.p2
      # mac: 74:86:e2:10:9f:6d

      # sw2.p3
      # mac: b4:96nixos:91:cd:04:c4

      # sw1.p3
      # mac: b4:96:91:cd:04:c6
    };
  };

  # the network relies on time...
  time.timeZone = "America/Phoenix";
}
