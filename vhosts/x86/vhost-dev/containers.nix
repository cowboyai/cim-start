{
  dev = {
    autoStart = true;
    privateNetwork = false;
    config = import ../../../compute/dev/configuration.nix;
  };
  
  dns = {
    autoStart = true;
    privateNetwork = false;
    config = import ../../../compute/dns/configuration.nix;
  };
  
  nats = {
    autoStart = true;
    privateNetwork = false;
    config = import ../../../compute/nats/configuration.nix;
  };

}