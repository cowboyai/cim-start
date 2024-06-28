{
  description = "wasmCloud Development Environment";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # we want the nightly version of wasmCloud
    wasmcloud-src = {
      url = "github:wasmCloud/wasmCloud";
      nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      wash = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./virtual.nix
        ];
      };
    };
  };
}
