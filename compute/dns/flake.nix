{
  description = "CIM Domain Naming Environment";

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
      ns = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}