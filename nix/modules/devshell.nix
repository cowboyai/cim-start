{ ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells.default = pkgs.mkShell {
      name = "cim-shell";
      inputsFrom = [
        self'.devShells.rust
        config.pre-commit.devShell # See ./nix/modules/pre-commit.nix
      ];
      packages = with pkgs; [
        just
        nixd # Nix language server
        cargo-leptos
        cargo-generate
        dart-sass
        config.process-compose.cargo-doc-live.outputs.package
      ];
    };
  };
}
