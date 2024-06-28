{ config
, pkgs
, ...
}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "vault";
    search = [ "cim.thecowboy.ai" ];
    firewall.allowedTCPPorts = [ 22 4222 8222 ];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      fastfetch
      curl
      wget
      htop
    ];
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai" ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    zsh.enable = true;
    direnv.enable = true;
    git.enable = true;
  };

  # Enable the Vaultwarden service
  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "192.168.1.66";
      ROCKET_PORT = 8222;
      DOMAIN = "http://vault.cim.thecowboy.ai";
      SIGNUPS_ALLOWED = false;
    };
  };

  system.stateVersion = "24.05";
}
