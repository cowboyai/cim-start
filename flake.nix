{
  description = "My CIM flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    #systems.url = "github:nix-systems/default";
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
    , treefmt-nix
    , ...
    }:
    flake-parts.lib.mkFlake
      {
        inherit inputs;
      }
      {
        systems = [ "x86_64-linux" ];

        imports = [
          ./modules
        ];
      };
}
