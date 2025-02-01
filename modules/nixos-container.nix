{ pkgs, ... }:
{
  # Enable container mode
  boot.isContainer = true;

  # Configure Nix with flakes enabled
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Add basic utilities to the container
  environment.systemPackages = with pkgs; [
    nix
    nixVersions.stable
    git
    curl
    bash
    coreutils
    cacert
  ];

  # Configure shell environment for Nix
  programs.bash = {
    completion.enable = true;
    shellInit = ''
      export NIX_PATH=nixpkgs=${pkgs.path}
      export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
    '';
  };

  # Minimal networking configuration
  networking.firewall.enable = false;

  # Set locale for the container
  i18n.defaultLocale = "en_US.UTF-8";

  # Set system state version (matches your NixOS version)
  system.stateVersion = "25.05";
}
