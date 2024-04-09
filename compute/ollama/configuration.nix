{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "ollama";
  networking.firewall.allowedTCPPorts = [ 22 11434];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      ollama
    ];
    initialPassword = "cim";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
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