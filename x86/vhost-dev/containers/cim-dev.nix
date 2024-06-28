{
  autoStart = true;
  privateNetwork = true;
  hostBridge = "br-lan";
  localAddress = "192.168.1.81/24";
  bindMounts = {
    "/etc/resolv.conf" = {
      hostPath = "/etc/resolv.conf";
      isReadOnly = true;
    };
    "/run/opengl-driver" = {
      hostPath = "/run/opengl-driver";
      isReadOnly = true;
    };
  };
  config =
    { config
    , pkgs
    , ...
    }:
    {

      nixpkgs.config.allowUnfree = true;
      networking = {
        defaultGateway = "192.168.1.1"; # Same gateway as the host
        nameservers = [ "192.168.1.254" "1.1.1.1" ]; # Same DNS servers as the host
      };

      imports = [
        ../../../../compute/dev/configuration.nix
        ../../../../compute/dev/virtual.nix
        ../../../../compute/dev/gnome.nix
      ];
    };
}
