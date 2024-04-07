nix-build '<nixpkgs/nixos>' -A vm -I nixpkgs=channel:nixos-unstable -I nixos-config=./configuration.nix 
# run with:
# QEMU_KERNEL_PARAMS=console=ttyS0 ./result/bin/run-nixos-vm -nographic; reset
