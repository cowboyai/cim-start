{ config
, pkgs
, ...
}:
let
  testScript = ''
    import time

    # Check if the SSH service is running
    assert machine.succeed("systemctl is-active sshd")

    # Check that neo4j can run
    assert machine.succeed("systemctl is-active neo4j")

    # Add more health checks as needed
    print("All health checks passed!")
  '';
in
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "neo4j";
    search = [ "cim.thecowboy.ai" ];
    firewall.allowedTCPPorts = [ 22 4222 7687 7474 7473 2003 2004 ];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      graphviz
      neo4j
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

  services.neo4j = {
    enable = true;
    directories.home = "/var/lib/neo4j";
    defaultListenAddress = "0.0.0.0";
    bolt.tlsLevel = "DISABLED";
    https.enable = false;
  };

  system.activationScripts = {
    intialize-dbms = {
      text = ''
        neo4j-admin dbms set-initial-password neo4j
      '';
      deps = [];
    };
  };

  system.stateVersion = "24.05";
}
