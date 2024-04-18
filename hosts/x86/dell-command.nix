{
  description = "Ubuntu Jammy Docker Image for Dell Command Configure";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.${system}.default = pkgs.dockerTools.buildImage {
        name = "jammy-image";
        tag = "latest";
        contents = pkgs.dockerTools.mkPaths [
          pkgs.htop
          pkgs.neofetch
          wget
        ];
        config = {
          Cmd = [ "${pkgs.bash}/bin/bash" ]; # Run the 'hello' binary when the container starts
        };
      };

      defaultPackage.${system} = self.packages.${system}.default;
    };
}
