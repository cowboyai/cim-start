{
  inputs = {
    naersk.url = "github:nmattia/naersk/master";
    # This must be the stable nixpkgs if you're running the app on a
    # stable NixOS install.  Mixing EGL library versions doesn't work.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = github:edolstra/flake-compat;
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    naersk,
    ...
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      libPath = with pkgs;
        lib.makeLibraryPath [
          libGL
          libxkbcommon
          wayland
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr
        ];
      toolchain =
        (pkgs.rustChannelOf {
          rustToolchain = ./rust-toolchain.toml;
          sha256 = "";
        })
        .rust;
      naersk-lib = pkgs.callPackage naersk {inherit toolchain;};
    in {
      devShells.default = with pkgs;
        mkShell {
          buildInputs = [
            cargo
            cargo-insta
            pre-commit
            rust-analyzer
            rustPackages.clippy
            rustc
            rustfmt
            tokei
            xorg.libxcb
            pkg-config
            systemd
            alsa-lib
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
          LD_LIBRARY_PATH = libPath;
        };
    });
}
