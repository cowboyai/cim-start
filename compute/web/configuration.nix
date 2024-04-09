{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "web";
  networking.firewall.allowedTCPPorts = [ 80 8080 443 4443];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = true;
  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      dig
      nginx      
    ];
    initialPassword = "cim";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
    
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 8192; # megs... 64 megs
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your dev store.
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