{
  description = "CIM Initial Environment";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        modules = [
          ({ config, pkgs, ... }: {
            services.neo4j = {
              enable = true;
            };
          })
        ];
      in
      with pkgs;
      {
        devShells.default = mkShell {
            buildInputs = [
              just
              cacert
              openssl
              openssl.dev
              pkg-config
              zlib.dev
              graphviz
              neo4j
              direnv
            ];
            
          shellHook = ''
            if [ -f .env ]; then
              export $(grep -v '^#' .env | xargs)
            fi
            '';
        };
      }
    );
}
