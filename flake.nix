{
  description = "My CIM flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    inputs@{ nixpkgs
    , flake-parts
    , systems
    , nixos-generators
    , treefmt
    , ...
    }:
    let
      # Use our custom lib enhanced with nixpkgs and hm one
      lib = import ./nix/lib { lib = nixpkgs.lib; } // nixpkgs.lib;
    in
    flake-parts.lib.mkFlake
      {
        inherit inputs;
        specialArgs = { inherit lib; };
      }
      {
        systems = [ "x86_64-linux" ]; #import inputs.systems;

        imports = [
          ./modules
        ];

        perSystem = { inputs', ... }: {
          # make pkgs available to all `perSystem` functions
          module.args.pkgs = inputs'.nixpkgs.legacyPackages;
          # make custom lib available to all `perSystem` functions
          module.args.lib = lib;
        };
      };
}
