{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

  outputs = { nixpkgs, ... }:
    {
      nixosConfigurations.vhost-dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./vhost-dev/configuration.nix
        ];
      };
    };
}