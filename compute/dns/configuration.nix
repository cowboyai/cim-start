{
  config,
  pkgs,
  ...
}: let
  testScript = ''
    import time

    # Check if the SSH service is running
    assert machine.succeed("systemctl is-active sshd")

    # Check that unbound can run
    assert machine.succeed("systemctl is-active unbound")


    # Add more health checks as needed
    print("All health checks passed!")
  '';
in {
  imports = [
    ./users.nix
    ./programs.nix
  ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "ns";
    search = ["cim.thecowboy.ai"];
    firewall.allowedTCPPorts = [22 53 853];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
    };

    resolved = {
      # Disable local DNS stub listener on 127.0.0.53 so we can use Unbound instead
      extraConfig = ''
        DNSStubListener=no
      '';
    };

    unbound = import ./unbound.nix;
  };
}
