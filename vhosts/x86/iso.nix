{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    "${pkgs.path}/nixos/modules/profiles/all-hardware.nix"
    "${pkgs.path}/nixos/modules/profiles/base.nix"
    "${pkgs.path}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
  ];

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

  # Include custom files in the ISO image
  system.build.isoImage = let
    configFiles = pkgs.runCommandNoCC "config-files" {} ''
      mkdir -p $out/conf
      cp -r ${./vhost-dev}/* $out/conf
    '';
  in
  pkgs.nixos.isoImage {
    name = "vhost-dev-iso";
    contents = [
      configFiles
    ];
    config.system.build.toplevel = config.system.build.toplevel;
  };

  system.stateVersion = "24.05";
}
