{ config, lib, pkgs, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/profiles/all-hardware.nix>
		<nixpkgs/nixos/modules/profiles/base.nix>
  ];

	nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "vhost-dev";

  nixpkgs.config.allowUnfree = true;

  #allow mdns for .local
  #remove this in prod
  services.avahi = {
		enable = true;
		ipv4 = true;
		ipv6 = false;
		nssmdns4 = true;
		publish = { enable = true; domain = true; addresses = true; };
	};

  # we remove this in prod...
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    git.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    htop
    neofetch
    nano
    openssl
    pciutils
    pv
    zip
    cacert
    curl 
    wget
  ];

  system.stateVersion = "24.05";
}