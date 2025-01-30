{ inputs, ... }: {
  perSystem = { pkgs, self', lib, ... }:
    let
      inherit (lib.importTOML (inputs.self + "/Cargo.toml")) package;
    in
    {
      packages.cimImage = pkgs.dockerTools.buildLayeredImage {
        name = package.name;
        tag = "latest";

        contents = [
          (self'.devShells.default.buildInputs or [ ])
          (self'.devShells.default.packages or [ ])
          (self'.packages.${package.name})
          pkgs.bashInteractive
        ];

        config = {
          Cmd = [ "${self'.packages.${package.name}}/bin/${package.name}" ];
          WorkingDir = "/src";
          Volumes = {
            "/src" = { };
          };
        };
      };
    };
}
