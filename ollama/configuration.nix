{ nixpkgs, ... }:
let 
  description = "Domain Ollama Environment VM";
  pkgs = nixpkgs.legacyPackages.x86_64-linux;
in
{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "ollama";

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