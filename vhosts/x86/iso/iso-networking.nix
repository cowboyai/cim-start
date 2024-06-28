# iso-networking.nix
{...}: {
  networking.hostName = "vhostdeviso";
  networking.search = ["cim.thecowboy.ai"];

  networking.wireless.enable = true; # Enable wireless networking
  networking.wireless.networks = {
    "cim-dev" = {
      psk = "Unsecure!";
    };
  };
}
