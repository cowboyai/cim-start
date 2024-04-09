{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "nats";
  networking.firewall.allowedTCPPorts = [ 22 4222];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      natscli
      nats-server
      nsc
      #benthos
      go
    ];
    initialPassword = "cim";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];    
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 64; # megs... 64 megs
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
    git.enable = true;
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
  ];

  # Hardening
  # environment.defaultPackages = lib.mkForce [];

  # start nats with systemd (as a user service)
  systemd.user.services.nats = {
    enable = true;

    unitConfig = {
      Description = "nats server instance";
      Type = "simple";
      PrivateTmp = true;
      After = "network-online.target ntp.service";
    };

    serviceConfig = {
      ExecStart = "${pkgs.nats-server}/bin/nats-server -js ";
      ExecReload = "";
      ExecStop = "";
      KillSignal = "SIGUSR2";
    };

    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "24.05";
}