{
  description = "Build Raspberry PI 4 image";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
  };
  outputs = { self, nixpkgs }: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
        inherit system;
    };
    nixosConfigurations.rpi4 = nixpkgs.lib.nixosSystem {
      inherit system pkgs;
      modules = [
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
        ({ ... }: {
          config = {
            time.timeZone = "America/Phoenix";
            sdImage.compressImage = false;

            users.users.root.initialHashedPassword = "$y$j9T$07MZ4fj47Q8ghrG5QZZ0M.$iuJZ97ocoprPTIT/sAt.yB1vSuNT8AdIU5X3UXPIEu/"; # use mkpasswd to generate
            system = {
              stateVersion = "23.11";
            };
            networking = {
              wireless.enable = false;
              useDHCP = false;
            };
            environment.systemPackages = with pkgs; [ git gnupg htop ];
          };
        })
      ];
    };
    in {
      image.rpi4 = nixosConfigurations.rpi4.config.system.build.sdImage;
    };

}