{
  description = "Auto-install vhost ISO";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = false;
          };
        };
      in
      {
        defaultPackage = pkgs.nixosConfigurations.installer.config.system.build.isoImage;
        nixosConfigurations.installer = pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ pkgs, ... }: {
              imports = [
                ./configuration.nix
              ];
              
              # Include your auto-install script
              systemd.services.auto-installer = {
                enabled = true;
                script = ''
                  #!/bin/sh
                  # Your installation commands go here
                  # For example, partitioning and nixos-install
                  echo "Running the auto-installation..."
                '';
                wantedBy = [ "multi-user.target" ];
              };

              environment.systemPackages = with pkgs; [
                # Any packages you need available in the ISO
              ];

              # Set the auto-installer to run at boot
              systemd.services.auto-installer.wantedBy = [ "default.target" ];
            })
          ];
        };
      });
}
