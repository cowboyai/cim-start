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

  # copy the install files to the right place
  isoImage.isoName = lib.mkForce "cim-vhost-dev-install.iso";
  environment.etc.nixos.source =
    builtins.filterSource
      (path: type:
        baseNameOf path
        != ".git"
        && type != "symlink"
        && baseNameOf path != "secrets")
      ./vhost-dev/.;

  system.stateVersion = "24.05";
}
