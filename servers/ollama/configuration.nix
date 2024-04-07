{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "ollama";
  networking.firewall.allowedTCPPorts = [ 22 ];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.ollama = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      ollama
    ];
    initialPassword = "ollama";
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 16384; 
      cores = 4;
      graphics = false;
      diskSize = 32 * 1024;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };
  
  environment.systemPackages = with pkgs; [
    htop
    just
    cacert
    openssl
    openssl.dev
    pkg-config
    zlib.dev
    direnv
    curl
    git
  ];

  system.stateVersion = "24.05";
}