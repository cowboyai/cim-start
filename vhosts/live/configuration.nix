{ modulesPath, config, lib, pkgs, ... }: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/profiles/qemu-guest.nix")
    ./disk-config.nix
  ];
  boot.loader.grub = {
    # no need to set devices, disko will add all devices that have a EF02 partition to the list already
    # devices = [ ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.kernelModules = [ "kvm-intel" ];
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
  };

  networking.hostName = "vhost-dev";
  networking.firewall.allowedTCPPorts = [ 22 443 ];

  services.openssh.enable = true;

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
  

  system.stateVersion = "23.11";
}