{ config, pkgs, ... }:
{
  imports = [
    ./users.nix
    ./programs.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ns";

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

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

    unbound = import ./unbound.nix;
  };

}