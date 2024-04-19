{ config, pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-intel" ]; #we only use intel here, for amd use "kvm-amd" 

  networking.hostName = "vhost-dev";
  networking.firewall.allowedTCPPorts = [ 22 443 ];

  # harden for prod...
  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  # harden for prod
  users.mutableUsers = true;
  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      #virt-manager
    ];
    initialPassword = "cim";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];    
  };

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;
  services.qemuGuest.enable = true;
  
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
    cacert
    openssl
  ];

  system.stateVersion = "24.05";
}