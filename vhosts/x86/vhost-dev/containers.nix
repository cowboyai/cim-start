{
  dev = {
    autoStart = true;
    privateNetwork = true;
    config = import ../../../compute/dev/configuration.nix;
  };
  
  dns = {
    autoStart = true;
    privateNetwork = true;
    config = import ../../../compute/dns/configuration.nix;
  };
  
  nats = {
    autoStart = true;
    privateNetwork = true;
    config = import ../../../compute/nats/configuration.nix;
  };

}