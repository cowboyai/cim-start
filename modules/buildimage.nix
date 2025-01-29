{ ... }: {
  perSystem = { pkgs, self', ... }: {
    packages.cimImage = pkgs.dockerTools.buildLayeredImage {
      name = "cim";
      tag = "latest";

      contents = [
        (self'.devShells.default.buildInputs or [ ])
        (self'.devShells.default.packages or [ ])
      ];

      config = {
        Cmd = [ "/bin/bash" ];
        WorkingDir = "/src";
        Volumes = {
          "/src" = { };
        };
      };
    };
  };
}
