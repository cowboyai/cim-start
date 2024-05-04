{
  dev = {
    autoStart = true;
    hostBridge = "enp0s0";
    config = import ../../../compute/dev/configuration.nix;
  };
  
  dns = {
    autoStart = true;
    hostBridge = "enp0s0";
    config = import ../../../compute/dns/configuration.nix;
  };
  
  nats = {
    autoStart = true;
    hostBridge = "enp0s0";
    config = import ../../../compute/nats/configuration.nix;
  };

}