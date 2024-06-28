{
  config,
  pkgs,
  ...
}: let
  wwwFiles = pkgs.copyPathToStore ./www;
in {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "web";
    search = ["cim.thecowboy.ai"];
    firewall.allowedTCPPorts = [80 8080 443 4443];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = true;
  users.users.cim = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      dig
      nginx
    ];
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

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
    fastfetch
  ];

  services.nginx = {
    enable = true;
    virtualHosts = {
      "web.cim.thecowboy.ai" = {
        root = "/var/lib/www";
        forceSSL = false;
        enableACME = false;
      };
    };
  };

  system.activationScripts = {
    copyWWWFiles = {
      text = ''
        mkdir -p /var/lib/www
        cp -R ${wwwFiles}/* /var/lib/www/
        chown -R www:www /var/lib/www
      '';
      deps = [];
    };
  };

  system.stateVersion = "24.05";
}
