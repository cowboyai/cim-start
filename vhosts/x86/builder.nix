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
      cd /etc/nixcfg

      # # fix a bug where wpa_supplicant doesn't start...
      # sudo systemctl restart wpa_supplicant.service
      # sleep 20
      # wait
      # ip addr 

      nix --experimental-features "nix-command flakes" \
      run 'github:nix-community/disko#disko-install' -- --flake '.#vhost-dev' \
      --write-efi-boot-entries \
      --disk sys /dev/nvme0n1 \
      --disk data /dev/nvme1n1

      # let disko finish
      wait $process_id

      echo 'Shutting off now'
      
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
