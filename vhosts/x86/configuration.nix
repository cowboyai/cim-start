{ config, lib, pkgs, ... }:
{

  imports = [
    <nixpkgs/nixos/modules/profiles/all-hardware.nix>
		<nixpkgs/nixos/modules/profiles/base.nix>
		#installer-only ./hardware-configuration.nix
  ];

	nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };

  # detected gpus cause X11 to install and 
  # we don't want it in the base
  services.xserver.enable = lib.mkForce false;

  nixpkgs.config.allowUnfree = true;
	zramSwap.enable = true;

  # harden for prod...
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = false;

  users.users.root = {
		hashedPassword = lib.mkForce "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
	};

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    useDefaultShell = false;
    shell = pkgs.zsh;
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];    
  };
  
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
    zsh.enable = true;
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
    openssl
    curl 
    wget
  ];

  system.stateVersion = "24.05";
}