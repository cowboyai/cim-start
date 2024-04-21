{
  description = "A NixOS ISO Flake for VHosts"; 

  ### WARNING: THE ISO PRODUCED WILL WIPE DRIVES WITHOUT ASKING
  ###          Be sure you intend to destroy them machine this is used on

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: {
      nixosConfigurations.vhostiso = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
          ./configuration.nix
          ./builder.nix
        ];
      };

      packages.x86_64-linux.default = self.nixosConfigurations.vhostiso.config.system.build.isoImage;
    });
}
