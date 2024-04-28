{
  description = "A NixOS ISO Flake for CIM VHosts";

  ### WARNING: THE ISO PRODUCED WILL WIPE DRIVES WITHOUT ASKING
  ###          Be sure you intend to destroy the machine this is used on

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      vhostiso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./iso.nix
          ./iso-networking.nix
          ./builder.nix
        ];
      };
    };
  };
}
