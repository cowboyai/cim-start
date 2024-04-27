{ pkgs, config, lib, ... }:
{
  #description = "Service to provision the system";

  systemd.services.install = {
    description = "Bootstrap a NixOS installation";
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" "polkit.service" ];
    path = [ "/run/current-system/sw/" ];
    script = with pkgs; ''
      echo 'journalctl -fb -n100 -uinstall' >>~nixos/.bash_history

      install -D ${./disk-config.nix} /tmp/disk-config.nix

      sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disk-config.nix

      # do detection better ffs.
      sleep 20

      install -D ${./flake.nix} /mnt/etc/nixos/flake.nix
      install -D ${./configuration.nix} /mnt/etc/nixos/configuration.nix
      install -D ${./hardware-configuration.nix} /mnt/etc/nixos/hardware-configuration.nix
      install -D ${./containers.nix} /mnt/etc/nixos/containers.nix

      ${config.system.build.nixos-install}/bin/nixos-install --flake .#vhost-dev

      echo 'Shutting off now'
      ${systemd}/bin/shutdown now
    '';
    environment = config.nix.envVars // {
      inherit (config.environment.sessionVariables) NIX_PATH;
      HOME = "/root";
    };
    serviceConfig = {
      Type = "oneshot";
    };
  };
}
