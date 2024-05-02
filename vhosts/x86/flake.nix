{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  inputs.disko.url = "github:nix-community/disko";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { nixpkgs, disko, ... }:
    {
      nixosConfigurations.vhost-dev = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./vhost-dev/configuration.nix
        ];
      };
    };
}