{ config, pkgs, ... }:
{
  description = "Domain neo4j Environment VM";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.neo4j = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      just
      cacert
      openssl
      openssl.dev
      pkg-config
      zlib.dev
      graphviz
      neo4j
      direnv
    ];
    initialPassword = "neo4j";
  };

  system.stateVersion = "24.05";
}
