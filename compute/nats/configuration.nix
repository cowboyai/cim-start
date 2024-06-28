{
  config,
  pkgs,
  ...
}: let
in {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "nats";
    search = ["cim.thecowboy.ai"];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = ["wheel" "nats"]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [

    ];
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
  };

  users.users.nats = {
    isSystemUser = true;
    group = "nats";
  };

  users.groups.nats = {};

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    zsh.enable = true;
    direnv.enable = true;
    git.enable = true;
  };

  environment.etc = {
    "nats/nats-init.sh" = {
      source = ./nats-init.sh;
      mode = "0755"; # Make the script executable
    };
  };

  environment.systemPackages = with pkgs; [
    htop
    fastfetch
    just
    cacert
    openssl
    openssl.dev
    pkg-config
    zlib.dev
    curl
    natscli
    nats-server
    nsc
  ];

  systemd.services.nats-config = {
    description = "Initialize nats service";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target" "polkit.service"];
    requires = ["network-online.target"];
    path = ["/run/current-system/sw/"];
    script = "/etc/nats/nats-init.sh";
    environment =
      config.nix.envVars
      // {
        inherit (config.environment.sessionVariables) NIX_PATH;
        HOME = "/root";
      };
    serviceConfig = {
      Type = "oneshot";
    };
  };

  systemd.services.nats-server = {
    description = "NATS Server";
    after = [ "network.target" "nats-config.service" ];
    requires = [ "nats-config.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.nats-server}/bin/nats-server -c /nats/secrets/cowboyai-resolver.conf";
      Restart = "on-failure";
      User = "nats";
      Group = "nats";
    };
  };

  system.stateVersion = "24.05";
}
