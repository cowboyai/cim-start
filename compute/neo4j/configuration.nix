{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "neo4j";
  networking.firewall.allowedTCPPorts = [ 22 4222];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.neo4j = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      neo4j
    ];
    initialPassword = "neo4j";
    #openssh.authorizedKeys.keys = [""];
    
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 16384;
        cores = 2;
        graphics = false;
        diskSize = 32768; #set this to however big you want your database for now... we move it to S3 later
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

  # start neo4j with systemd (as a user service)
  systemd.user.services.neo4j = {
    enable = true;

    unitConfig = {
      Description = "neo4j server instance";
      Type = "simple";
      PrivateTmp = true;
      After = "network-online.target ntp.service";
    };

    serviceConfig = {
      ExecStart = "${pkgs.neo4j}/bin/neo4j start";
      ExecReload = "";
      ExecStop = "";
      KillSignal = "SIGUSR2";
    };

    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "24.05";
}