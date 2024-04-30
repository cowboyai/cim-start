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
      echo 'ip a' >>~nixos/.bash_history
      echo 'sudo systemctl restart wpa_supplicant.service'  >>~nixos/.bash_history
      echo 'sudo systemctl restart install.service &'  >>~nixos/.bash_history
      echo 'journalctl -fb -n100 -uinstall' >>~nixos/.bash_history

      cd /etc/nixcfg

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
