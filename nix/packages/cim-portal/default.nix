{ dream2nix
, config
, lib
, self
, ...
}: {
  imports = [
    dream2nix.modules.dream2nix.mkDerivation
  ];

  name = "cim-portal";
  version = "0.1.0";

  deps = { nixpkgs, ... }: {
    inherit
      (nixpkgs)
      stdenv
      ;
  };

  mkDerivation = {
    src = builtins.fetchFromGitHub {
      owner = "thecowboyai";
      repo = "cim-portal";
      rev = "0.1.0";

      sha256 = "";

      leaveDotGit = true;
    };
  };
}
