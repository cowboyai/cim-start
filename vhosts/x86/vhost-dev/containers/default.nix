{
  boot.enableContainers = true;
  containers = {
    cim-dev = import ./cim-dev.nix;
    dns = import ./dns.nix;
    ipa = import ./ipa.nix;
    nats = import ./nats.nix;
    wash = import ./wash.nix;
    ollama = import ./ollama.nix;
    neo4j = import ./neo4j.nix;
    vault = import ./vault.nix;
    web = import ./web.nix;
    agents = import ./agents.nix;
  };
}
