{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ns";
  networking.firewall.allowedTCPPorts = [ 53 123 53 847 5353 8245 ];

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
      nmap
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
        diskSize = 32768; #set this to however big you want your object store for now... we move it to S3 later
      };
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    resolved = {
      # Disable local DNS stub listener on 127.0.0.53 so we can use Unbound instead
      extraConfig = ''
        DNSStubListener=no
      '';
    };

    unbound = {
      enable = true;
      settings = {
        server = {
          interface = [ "127.0.0.1" ];
        };

        local-zone = "domain.cim.";

        local-data = [
          "gateway.domain.cim.   IN A 192.168.200.1"
          "nats.domain.cim.      IN A 192.168.200.2"
          "ollama.domain.cim.    IN A 192.168.200.3"
          "neo4j.domain.cim.     IN A 192.168.200.4"
          "dev.domain.cim.       IN A 192.168.200.5"
          "apis.domain.cim.      IN A 192.168.200.6"
          "web.domain.cim.       IN A 192.168.200.7"
          "ns.domain.cim.        IN A 192.168.200.254"
        ];

        local-data-ptr = [
          "192.168.200.1  gateway.domain.cim"
          "192.168.200.2  nats.domain.cim"
          "192.168.200.3  ollama.domain.cim"
          "192.168.200.4  neo4j.domain.cim"
          "192.168.200.5  dev.domain.cim"
          "192.168.200.6  apis.domain.cim"
          "192.168.200.7  web.domain.cim"
          "192.168.200.254  ns.domain.cim"
        ];

        forward-zone = [
          {
            name = ".";
            forward-addr = "1.1.1.1@853#cloudflare-dns.com";
          }
          {
            name = "cim.thecowboy.ai.";
            forward-addr = [
              "1.1.1.1@853#cloudflare-dns.com"
              "1.0.0.1@853#cloudflare-dns.com"
            ];
          }
        ];
        remote-control.control-enable = true;
      };
    };
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