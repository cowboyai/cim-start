{
  autoStart = true;
  privateNetwork = true;
  hostBridge = "br-lan";
  localAddress = "192.168.1.32/24";
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
      imports = [
        ../../../../compute/wash/configuration.nix
        ../../../../compute/wash/virtual.nix
      ];
    };
}
