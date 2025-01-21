{ ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells = {
      default = pkgs.mkShell (import ./shells/defaultshell.nix { inherit pkgs; });
    };

  };
}
