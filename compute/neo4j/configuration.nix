{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking.hostName = "neo4j";
  networking.firewall.allowedTCPPorts = [ 22 4222 7687 7474 7473 2003 2004 ];

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      neo4j
    ];
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
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