{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
    ...
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        stdenv = pkgs.clangStdenv;
        rustToolchain = pkgs.pkgsBuildHost.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      in
        with pkgs; {
          modules = [
            nix-ld.nixosModules.nix-ld
            {programs.nix-ld.dev.enable = true;}
          ];

          devShells.default = mkShell {
            buildInputs = [
              rustToolchain
              cargo-edit
              cargo-expand
              cargo-udeps
              cargo-whatfeatures
              cargo-leptos
              cargo-generate
              cargo-make
              cacert
              trunk
              direnv
              lld
              clang
              gcc
              zsh
              git
              just
              starship
              openssl
              openssl.dev
              pkg-config
              zlib.dev
              alsa-lib
              xorg.libX11
              xorg.libXi
              xorg.libXcursor
              libpulseaudio
              libGL
              libglvnd
              libiconv
              tailwindcss
              sass
              glibc
            ];

            RUST_SRC_PATH = rustPlatform.rustLibSrc;
            # see: https://discourse.nixos.org/t/running-a-rust-application-that-needs-egl-with-shell-nix/33245/3
            LD_LIBRARY_PATH = "${pkgs.libglvnd}/lib";

            shellHook = ''
              if [ -f .env ]; then
                export $(grep -v '^#' .env | xargs)
              fi
              export GIT_CONFIG_NOSYSTEM=1
              ZSH_CUSTOM=$HOME/.config/zsh
              export PATH="$HOME/.cargo/bin:$PATH"
              export LD_LIBRARY_PATH="${pkgs.libglvnd}/lib";
            '';
          };
        }
    );
}
