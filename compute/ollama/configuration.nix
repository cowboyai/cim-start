{
  config,
  pkgs,
  ...
}: let
  testScript = ''
    import time

    # Check if the SSH service is running
    assert machine.succeed("systemctl is-active sshd")

    # Check that ollama is running in user space
    assert machine.succeed("systemctl is-active --user ollama")

    # systemctl status --user ollama | grep "Listening on 127.0.0.1:11434" | wc -l
    # should = 1
    # this is the default instance
    # other models can run on other ports

    # Add more health checks as needed
    print("All health checks passed!")
  '';
in {
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "ollama";
    search = ["cim.thecowboy.ai"];
    firewall.allowedTCPPorts = [22 4222 11434];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = ["wheel" ""]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      oterm
      fastfetch
      curl
      wget
      htop
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
    git.enable = true;
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
  ];

  environment.variables = {
    OLLAMA_MODELS = "/var/lib/ollama/models";
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/ollama/models 0755 ollama ollama -"
  ];

  # start ollama with systemd (as a user service)
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_MODELS = "/var/lib/ollama/models";
    };
  };
  
  systemd.user.services.ollama = {
    enable = true;
    description = "ollama server instance";
    unitConfig = {
      Type = "simple";
      # ...
    };
    serviceConfig = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
    };
    wantedBy = ["default.target"];
  };

  system.stateVersion = "24.05";
}
