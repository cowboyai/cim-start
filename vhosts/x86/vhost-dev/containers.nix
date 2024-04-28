{
  dev = {
    autoStart = true;
    privateNetwork = true;
    config = import ./dev/configuration.nix;
  };
  
  dns = {
    autoStart = true;
    privateNetwork = true;
    config = import ./dns/configuration.nix;
  };
  
  nats = {
    autoStart = true;
    privateNetwork = true;
    config = import ./nats/configuration.nix;
  };

}