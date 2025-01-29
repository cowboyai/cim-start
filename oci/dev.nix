{ ... }: {
  perSystem = { config, self', pkgs, lib, nixpkgs, ... }: {
    # Define the NixOS configuration for container
    nixosConfigurations.dev = nixpkgs.lib.nixosSystem {
      system = config.system;
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            helix
            git
          ];

          services.sshd.enable = true;
        })
      ];
    };
  };
}
