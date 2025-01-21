{
  description = "CIM - Composable Information Machine";

  inputs = {
    dream2nix.url = "github:nix-community/dream2nix";
    nixpkgs.follows = "dream2nix/nixpkgs";
  };

  outputs = { self, dream2nix, nixpkgs, ... }:
    let
      eachSystem = nixpkgs.lib.genAttrs [
        "x86_64-linux"
      ];
    in
    {

      packages = eachSystem (system:
        dream2nix.lib.importPackages {
          projectRoot = "./.";
          projectRootFile = "flake.nix";
          packagesDir = ./packages;
          packageSets.nixpkgs = nixpkgs.legacyPackages.${system};
        }
      );

    };
}
