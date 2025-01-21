{ ... }:
{
  perSystem = { config, self', pkgs, lib, ... }: {
    devShells = {
      default = import ./defaultshell.nix { inherit pkgs; };
    };

  };
}
