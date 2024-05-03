# network.nix
{...}: {
	networking.wireless.enable = true; # Enable wireless networking
  networking.wireless.networks = {
    "cim-dev" = {
      psk = "Unsecure!";
    };
  };

	networking.networkmanager.unmanaged = [
    "*" "except:type:wwan"
	];
  networking.networkmanager.enable = true;
  
  networking.hostName = "vhost-dev";
  
  networking.firewall.allowedTCPPorts = [ 22 443 ];

	# we have at least 2 networks to manage...
	# network #1 the LAN
	# network #2 the containers
	# network #x for isolated containers

	# this machine has 5 network interfaces
	# 4 wired and 1 wireless

	# dhcp or enable settings below

	# networking.defaultGateway = "192.168.1.1"; 

	# networking.interfaces.wlp101s0.useDHCP = false;
	# networking.interfaces.wlp101s0.ipv4.addresses = [
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


	# the network relies on time...
	
  # TIME
  time.timeZone = "America/Phoenix";
  
}
