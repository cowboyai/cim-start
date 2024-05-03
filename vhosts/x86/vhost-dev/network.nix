# network.nix
{...}: {
  networking.networkmanager.enable = true;
  networking.wireless.networks."cim-dev" = { psk = "Unsecure!"; };
  
  networking.hostName = "vhost-dev";
  
  networking.firewall.allowedTCPPorts = [ 22 443 ];

	# we have at least 2 networks to manage...
	# network #1 the LAN
	# network #2 the containers
	# network #x for isolated containers

	# this machine has 5 network interfaces
	# 

	# networking.interfaces.wl0.useDHCP = false;
	# networking.interfaces.wl0.ipv4.addresses = [
	# 	{
	# 		address = "192.168.1.102";
	# 		prefixLength = 24;
	# 	}
	# ];

	# networking.interfaces.enp2s0.useDHCP = false;
	# networking.interfaces.enp2s0.ipv4.addresses = [
	# 	{
	# 		address = "192.168.1.101";
	# 		prefixLength = 24;
	# 	}
	# ];

  # TIME
  time.timeZone = "America/Phoenix";
  
}
