{
  description = "Rust devshell for developing a CIM";
  # This Flake is for developing everything from this git repo, not an actual install
  #

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
        with pkgs; {
          # start ollama with systemd (as a user service)
          services.ollama.enable = true;
          systemd.user.services.ollama = {
            enable = true;
            description = "ollama server instance";
            unitConfig = {
              Type = "simple";
              # ...
            };
            serviceConfig = {
              ExecStart = "${pkgs.ollama}/bin/ollama serve";
            };
            wantedBy = ["default.target"];
          };
          devShells.default = mkShell {
            buildInputs = [
              nix-index
              nixfmt
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
              #ciscoPacketTracer8
              wasm-tools
              wasmtime
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

              # support cargo installs
              export PATH=$PATH:~/.cargo/bin

              # wasm support
              export BINDGEN_EXTRA_CLANG_ARGS="-isystem ${pkgs.clang}/resource-root/include $NIX_CFLAGS_COMPILE"
            '';
          };
        }
    );
}
