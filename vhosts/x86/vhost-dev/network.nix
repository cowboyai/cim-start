# network.nix
{...}: {
  networking.wireless.enable = true; # Enable wireless networking
  networking.wireless.networks = {
    "cim-dev" = {
      psk = "Unsecure!";
    };
  };
  
  networking.hostName = "vhost-dev";
  
  networking.firewall.allowedTCPPorts = [ 22 443 ];
	# networking.interfaces.enp2s0.useDHCP = false;
	# networking.interfaces.enp2s0.ipv4.addresses = [
	# 	{
	# 		address = "192.168.100.2";
	# 		prefixLength = 29;
	# 	}
	# ];

  # TIME
  time.timeZone = "America/Phoenix";
  
}
