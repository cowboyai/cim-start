{
  config,
  pkgs,
  ...
}: let
  certdir = "/etc/raddb/certs";
  configText = ''
    eap {
      tls {
        private_key_password = "supersecretprivatekeynotintherepo!"
        private_key_file = ${certdir}/server.key
        certificate_file = ${certdir}/server.crt
      }
    }
    modules {
    }
  '';

in {
  imports = [
    ./users.nix
    ./programs.nix
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "ipa";
    search = ["cim.thecowboy.ai"];
    firewall.allowedTCPPorts = [22];
    firewall.allowedUDPPorts = [1812];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    freeradius = {
      enable = true;
      configDir = pkgs.writeTextDir "radiusd.conf" configText;
    };
  };

    system.activationScripts = {
    intialize-dbms = {
      text = ''
        ipa-server-install
      '';
      deps = [];
    };
  };
}
