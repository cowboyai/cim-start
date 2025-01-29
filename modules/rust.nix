{ inputs, ... }:
{
  perSystem = { config, self', pkgs, lib, ... }:
    let
      inherit (lib.importTOML (inputs.self + "/Cargo.toml")) package;
    in
    {
      packages = {
        ${package.name} = pkgs.rustPlatform.buildRustPackage {
          inherit (package) version;
          cargoLock.lockFile = (inputs.self + "/Cargo.lock");

          pname = package.name;
          src = inputs.self;
        };

        default = config.packages.${package.name};
      };
    };
}
