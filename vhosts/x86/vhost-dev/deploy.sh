### WARNING ###
# whatever is on your network at this IP address is going to get clobbered destructively
# be sure it matches the hardware-configuration you want and the IP address is correct
# you obviously need to be connected to this network on a different IP
# we recommend <you machine on some IP>... the target being a different IP 
# and maybe your router the only other thing on this network during initial configuration
nix run github:nix-community/nixos-anywhere -- --flake .#vhost-dev root@192.168.1.23 -i ~/.ssh/id_cim_thecowboyai
