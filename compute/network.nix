{
  network.description = "CIM";

  dev = 
    { config, pkgs, ... }:
    { 
      services.httpd.enable = true;
      services.httpd.adminAddr = "admin@domain.cim";
    };

  dns =
    { config, pkgs, ... }:
    { 
      services.unbound.enable = true;
    };

  nats =
    { config, pkgs, ... }:
    {
      services.nats-server.enable = true;
      services.nats-server.package = pkgs.nats-server;
    };
}