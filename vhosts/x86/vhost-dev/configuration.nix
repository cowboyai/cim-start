{ config, lib, pkgs, ... }:
{

  imports = [
		./hardware-configuration.nix
   "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
   ./disk-config.nix
   ./network.nix
  ];

	nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
        experimental-features = nix-command flakes
    '';
  };

  services.xserver.enable = lib.mkForce true;
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "vhost-dev";

  nixpkgs.config.allowUnfree = true;

  # harden for prod...
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = true;

  users.users.root = {
		#hashedPassword = lib.mkForce "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
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
    curl 
    wget
];

  boot.enableContainers = true;
  containers = (import ./containers.nix);


	fileSystems."/boot" = {
		device = lib.mkForce "/dev/disk/by-partlabel/disk-sys-ESP";
		fsType = "vfat";
	};

	fileSystems."/" = {
		device = lib.mkForce "/dev/disk/by-partlabel/disk-sys-nixos";
		fsType = "ext4";
	};

	fileSystems."/data" = {
		device = lib.mkForce "/dev/disk/by-partlabel/disk-data-data";
		fsType = "ext4";
	};


  system.stateVersion = "23.11";
}