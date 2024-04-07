{
  description = "Rust devshell for developing in Leptos";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
      with pkgs;
      {
        devShells.default = mkShell {
            buildInputs = [
              nix-index
              rustToolchain
              cargo-generate
              cargo-make
              cargo-edit
              pkg-config
              just
              cmake
              gnumake
              llvmPackages.bintools
              clang
              clang-tools 
              llvmPackages.libclang.lib 
              cacert
              openssl
              openssl.dev
              zlib.dev
              clangStdenv
              graphviz
              jq
            ];
            
            LIBCLANG_PATH = "${pkgs.llvmPackages.libclang.lib}/lib";
            RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

          shellHook = ''
            # load .env
            if [ -f .env ]; then
              export $(grep -v '^#' .env | xargs)
            fi

            # For rust-analyzer 'hover' tooltips to work.
            export RUST_SRC_PATH=${pkgs.rustPlatform.rustLibSrc}
            export LIBCLANG_PATH=${pkgs.llvmPackages.libclang.lib}/lib

            export PATH=$PATH:~/.cargo/bin

            export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.clang}/resource-root/include $NIX_CFLAGS_COMPILE"
            '';
        };
      }
    );
}
