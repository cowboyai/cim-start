{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alsa-utils
    pavucontrol
    playerctl
    pulsemixer
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
    bind
    whois
    arp-scan
    nettools
    traceroute
    dig
    pciutils
    tcpdump
  ];
}
