{ config, pkgs, ... }:
{
  description = "Domain Ollama Environment VM";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.ollama = {
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
      direnv
      ollama
    ];
    initialPassword = "ollama";
  };

  system.stateVersion = "24.05";
}