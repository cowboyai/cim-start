{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "cim-dns";
  networking.firewall.allowedTCPPorts = [ 22 4222];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = true;
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      bind
      
    ];
    initialPassword = "nixos";
    #openssh.authorizedKeys.keys = [""];
    
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 8192; # megs... 64 megs
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your object store for now... we move it to S3 later
      };
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    zsh.enable = true;
    direnv.enable = true;
    starship.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    htop
    just
    cacert
    openssl
    openssl.dev
    pkg-config
    zlib.dev
    curl
    git
  ];

  system.stateVersion = "24.05";
}