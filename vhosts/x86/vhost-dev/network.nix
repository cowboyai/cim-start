# network.nix
{...}: {
  networking.networkmanager.enable = true;
  networking.wireless.networks."cim-dev" = { psk = "Unsecure!"; };
  
  networking.hostName = "vhost-dev";
  
  networking.firewall.allowedTCPPorts = [ 22 443 ];

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
