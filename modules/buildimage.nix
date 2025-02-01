{ inputs, ... }: {
  perSystem = { pkgs, self', lib, ... }:
    let
      inherit (lib.importTOML (inputs.self + "/Cargo.toml")) package;
    in
    {
      packages.cimImage = pkgs.dockerTools.buildImage {
        name = package.name;
        tag = "latest";

        fromImage = pkgs.dockerTools.pullImage {
          imageName = "nixos/nix";
          imageDigest = "sha256:42d51ae5882b7d9a6ad3237d356025445dc75903b1bfe4eb007a3426356e6c42";
          sha256 = "sha256-DIqKna92neP2gM60VlsVLpVwse76qB98KmNkIbvd13M=";
          finalImageTag = "latest";
        };

        contents = [
          (self'.devShells.default.buildInputs or [ ])
          (self'.devShells.default.packages or [ ])
          (self'.packages.${package.name})
        ];

        config = {
          Cmd = [
            #"${self'.packages.${package.name}}/bin/${package.name}" 
            "${pkgs.bashInteractive}/bin/bash"
          ];
          Env = [
            "WAYLAND_DISPLAY=wayland-1"
            "LD_LIBRARY_PATH=${builtins.foldl' (a: b: "${a}:${b}/lib") "" self'.devShells.default.buildInputs}"
          ];
          WorkingDir = "/src";
          Volumes = {
            "/src" = { };
            "/run/user/1000/wayland-1" = { };
          };
        };
      };
    };
}
