{ config, pkgs, ... }:
{
  description = "Domain NATS Environment VM";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.nixos = {
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
      nats
      benthos
      direnv
    ];
    initialPassword = "nixos";
  };

  system.stateVersion = "24.05";
}