{
  description = "Base system for raspberry pi 4";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }: 
  {
    nixosModules = {
      system = {
        # Disabling the whole `profiles/base.nix` module, which is responsible
        # for adding ZFS and a bunch of other unnecessary programs:
        disabledModules = [
          "profiles/base.nix"
        ];

        system.stateVersion = "23.11";
      };
      users = {
        users.users = {
          cim = {
            password = "cim";
            isNormalUser = true;
            extraGroups = [ "wheel" ];
          };
        };
      };
    };

    packages.aarch64-linux = {
      sdcard = nixos-generators.nixosGenerate {
        system = "aarch64-linux";
        format = "sd-aarch64";
        modules = [
          self.nixosModules.system
          self.nixosModules.users
        ];
      };
    };
  };
}