{ ... }:
{
  perSystem = { pkgs, lib, ... }: {
    devShells.default = pkgs.mkShell {
      name = "cim-shell";
      packages = with pkgs; [
        just
        nixd
      ];
    };
  };
}
