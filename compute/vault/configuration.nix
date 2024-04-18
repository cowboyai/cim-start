{ config, pkgs, ... }:
{
  # Enable the Vaultwarden service
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      DOMAIN = "https://vault.cim.local";
      SIGNUPS_ALLOWED = false;
    };
  };
}
