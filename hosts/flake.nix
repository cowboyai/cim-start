{
  description = "CIM Domain Development Environment";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
  in 
  {
    nixosConfigurations = {
      host-dev = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}