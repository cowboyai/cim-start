{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "cim-ollama";
  networking.firewall.allowedTCPPorts = [ 22 11434];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.ollama = {
    isNormalUser = true;
    extraGroups = [ "wheel" "" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      ollama
    ];
    initialPassword = "ollama";
  };

  virtualisation = {
    vmVariant = {
      virtualisation = {
        memorySize = 16384; 
        cores = 4;
        graphics = false;
        diskSize = 32 * 1024;
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
    #direnv
    curl
    git
  ];

  # start ollama with systemd (as a user service)
  systemd.user.services.ollama = {
    enable = true;
    description = "ollama server instance";
    unitConfig = {
      Type = "simple";
      # ...
    };
    serviceConfig = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
    };
    wantedBy = [ "default.target" ];
  };

  system.stateVersion = "24.05";
}