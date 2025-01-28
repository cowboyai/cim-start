{ ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells.default = pkgs.mkShell rec {
      name = "iced-devShell";
      # inputsFrom = [
      #   config.pre-commit.devShell # Implement ./nix/modules/pre-commit.nix
      # ];
      buildInputs = with pkgs; [
        expat
        fontconfig
        freetype
        freetype.dev
        libGL
        pkg-config
        xorg.libX11
        xorg.libXcursor
        xorg.libXi
        xorg.libXrandr
        wayland
        libxkbcommon
      ];

      # for the running shell
      packages = with pkgs; [
        just

        # Nix        
        nix-index
        nixpkgs-fmt
        nixd
        alejandra

        # Rust
        bacon

        # cargo
        cargo
        cargo-edit
        cargo-expand
        cargo-udeps
        cargo-whatfeatures
        cargo-generate
        cargo-make
        cargo-edit

        # wasm
        wasmtime
        wasmserve
        wasm-tools
        wasm-pack
        alsa-lib
      ];
      LD_LIBRARY_PATH =
        builtins.foldl' (a: b: "${a}:${b}/lib") "${pkgs.vulkan-loader}/lib" buildInputs;
    };
  };
}
