{
  autoStart = true;
  privateNetwork = true;
  hostBridge = "br-lan";
  localAddress = "192.168.1.254/24";
  bindMounts = {
    "/etc/resolv.conf" = {
      hostPath = "/etc/resolv.conf";
      isReadOnly = true;
    };
  };
  config =
    { config
    , pkgs
    , ...
    }: {
      networking = {
        defaultGateway = "192.168.1.1"; # Same gateway as the host
        nameservers = [ "192.168.1.254" "1.1.1.1" ]; # Same DNS servers as the host
      };

      networking.firewall.allowedTCPPorts = [ 53 853 ];
      networking.firewall.allowedUDPPorts = [ 53 853 ];
      imports = [
        ../../../../compute/dns/configuration.nix
        ../../../../compute/dns/virtual.nix
      ];
    };
}
