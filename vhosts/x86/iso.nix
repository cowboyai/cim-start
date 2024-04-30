{
  config,
  lib,
  pkgs,
  ...
}: {

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  networking.hostName = "vhostdeviso";
  nixpkgs.config.allowUnfree = true;

  services.avahi = {
    enable = true;
    ipv4 = true;
    ipv6 = false;
    nssmdns4 = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs.git.enable = true;

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

  # copy the install files to the iso
  isoImage.isoName = lib.mkForce "cim-vhost-dev-install.iso";

  system.activationScripts.copyConfigFiles = {
    text = ''
      # Ensure the target directory exists
      mkdir -p /etc/nixcfg/dev /etc/nixcfg/dns /etc/nixcfg/nats
      
      # build an inventory file
      echo "servicetag: \n" && cat /sys/class/dmi/id/product_serial >> /etc/nixcfg/inventory.yaml

      # Copy files to the target directory
      cp -r ${./vhost-dev}/* /etc/nixcfg/
      cp ${../../compute/dev/configuration.nix} /etc/nixcfg/dev/configuration.nix
      cp ${../../compute/dns/configuration.nix} /etc/nixcfg/dns/configuration.nix
      cp ${../../compute/nats/configuration.nix} /etc/nixcfg/nats/configuration.nix
    '';
    deps = [ "users" ];  # Run after the 'users' activation script
  };

  system.stateVersion = "24.05";
}
