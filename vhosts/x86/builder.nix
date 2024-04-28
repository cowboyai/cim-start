{
  pkgs,
  config,
  lib,
  ...
}: {
  #description = "Service to provision the system";

  systemd.services.install = {
    description = "Bootstrap a NixOS installation";
    wantedBy = ["multi-user.target"];
    after = ["network-online.target" "polkit.service"];
    requires = ["network-online.target"];
    path = ["/run/current-system/sw/"];
    script = with pkgs; ''
      echo 'journalctl -fb -n100 -uinstall' >>~nixos/.bash_history

      nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /etc/nixos/disk-config.nix
      process_id=$!
      
      # let disko finish
      wait $process_id

      ${config.system.build.nixos-install}/bin/nixos-install --flake /etc/nixos/flake.nix#vhost-dev

      echo 'Shutting off now'
      ${systemd}/bin/shutdown now
    '';
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
}
