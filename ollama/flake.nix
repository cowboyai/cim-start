{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {
    packages.x86_64-linux = {
      qcow = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        specialArgs = {
          nixpkgs = nixpkgs;
          diskSize = 128 * 1024; # 128G to hold models (think of this as a cache)
        };
        modules = [
          ./configuration.nix
        ];
        format = "qcow";        
      };
      default = self.packages.x86_64-linux.qcow;
    };
  };
}