{
  description = "Docker image with devshell using flake-parts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      #flake = import ./dev.nix { inherit nixpkgs; };

      # Import external modules (like devshell and rust)
      imports = [
        inputs.treefmt-nix.flakeModule
        ../modules/devshell.nix
        ../modules/rust.nix
        ./buildimage.nix
      ];
    };
}
