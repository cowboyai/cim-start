{
  config,
  lib,
  pkgs,
  ...
}: let
  # Define the test script
  # testScript = builtins.readFile ./tests.sh;
in {
  imports = [
    (fetchTarball {
        url = "https://github.com/nix-community/disko/archive/master.tar.gz";
        sha256 = "12rm6ral8mli5908h07q76lpp8bjmjx1i3sz4la7m694s5i5gnzm";
      }
      + "/module.nix")
    ./system.nix
    ./disk-config.nix
    ./hardware-configuration.nix
    ./omni-network.nix
    ./gnome.nix
    ./packages.nix
    ./security.nix
    ./users.nix
    ./services.nix
    ./programs.nix
    ./containers
  ];

  system.stateVersion = "24.05";
}
