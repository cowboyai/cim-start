{
  description = "CIM - Composable Information Machine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      # we debug things in a single system first, or we get a bunch of noise.
      systems = [ "x86_64-linux" ];
      #systems = import inputs.systems;

      # Import all modules from ./nix/modules/*.nix
      imports = with builtins;
        map
          (fn: ./nix/modules/${fn})
          (attrNames (readDir ./nix/modules));

    };
}
