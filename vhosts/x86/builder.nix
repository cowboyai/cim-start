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

      set -eux

      wait-for() {
        for _ in seq 10; do
          if $@; then
            break
          fi
          sleep 1
        done
      }

      dev=/dev/nvme0n1
      dev2=/dev/nvme1n1

      ${utillinux}/bin/sfdisk --wipe=always $dev <<-END
        label: gpt
        name=BOOT, size=512MiB, type=C12A7328-F81F-11D2-BA4B-00A0C93EC93B
        name=NIXOS
      END
      mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/BOOT

      sync
      wait-for [ -b /dev/disk/by-partlabel/BOOT ]

      wait-for mkfs.fat -F 32 -n boot /dev/disk/by-partlabel/BOOT

      wait-for mkfs.ext4 -L nixos /dev/mapper/root

      sync
      mount /dev/mapper/root /mnt

      mkdir /mnt/boot
      mkdir /mnt/data

      wait-for mount /dev/disk/by-label/boot /mnt/boot

      ${utillinux}/bin/sfdisk --wipe=always $dev2 <<-END
        label: gpt
        name=DATA
      END
      mkfs.ext4 -L data /dev/mapper/data

      wait-for mount /dev/disk/by-label/data /mnt/data

      install -D ${./flake.nix} /mnt/etc/nixos/flake.nix
      install -D ${./configuration.nix} /mnt/etc/nixos/configuration.nix
      install -D ${./hardware-configuration.nix} /mnt/etc/nixos/hardware-configuration.nix

      sed -i -E 's/(\w*)#installer-only /\1/' /mnt/etc/nixos/*

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
