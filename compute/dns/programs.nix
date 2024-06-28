{
  config,
  pkgs,
  ...
}: {
  programs = {
    zsh.enable = true;
    direnv.enable = true;
    starship.enable = true;
  };

  environment.systemPackages = with pkgs; [
    htop
    just
    cacert
    openssl
    openssl.dev
    pkg-config
    zlib.dev
    curl
    git
    inetutils
    nmap
    nmap-formatter
    dig
  ];

  system.stateVersion = "24.05";
}
