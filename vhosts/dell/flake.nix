{
  description = "NixOS configuration for vhost system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs, ... }@attrs: 
  {
    nixosConfigurations = { 
      "vhost-dev" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
        ];
      }; 
    };
  };
}