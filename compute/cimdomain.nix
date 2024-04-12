{
  network.description = "CIM Domain";

  # import all the VMs
  imports = [
    ./dev
    ./dns
    ./mail
    ./nats
    ./neo4j
    ./ollama
    ./web
  ];

  # web = 
  #   { config, pkgs, nodes, ... }:
  #   { deployment.targetEnv = "qemu";
  #     deployment.virtualbox.memorySize = 2048; # MB
  #   };

  # dns =
  #   { config, pkgs, nodes, ... }:
  #   { deployment.targetEnv = "qemu";
  #     deployment.virtualbox.memorySize = 1024; # MB 
  #   };
}
