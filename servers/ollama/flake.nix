{
  description = "Ollama Domain Environment";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
  };

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
  in 
  {
    nixosConfigurations = {
      ollama = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}