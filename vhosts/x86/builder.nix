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
      echo 'ip addr' >>~nixos/.bash_history
      echo 'sudo systemctl restart wpa_supplicant.service'  >>~nixos/.bash_history
      echo 'sudo systemctl restart install.service &'  >>~nixos/.bash_history
      echo 'journalctl -fb -n100 -uinstall' >>~nixos/.bash_history

      nix --experimental-features "nix-command flakes" run github:nix-community/disko -- \
          --mode disko /etc/nixcfg/disk-config.nix
      process_id=$!
      
      # let disko finish
      wait $process_id

      # copy the configs to the new drive
      echo 'copying configuration...'
      mkdir -p /mnt/etc/nixos
      cp -r /etc/nixcfg/* /mnt/etc/nixos
      echo 'copied configuration successful...'

      # actually install the system
      cd /mnt/etc/nixos
      echo $PWD

      echo 'Installing...'
      ${config.system.build.nixos-install}/bin/nixos-install --impure --flake .#vhost-dev

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
