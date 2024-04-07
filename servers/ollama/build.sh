nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-unstable -I nixos-config=./configuration.nix
