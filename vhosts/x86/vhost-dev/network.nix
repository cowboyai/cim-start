# network.nix
{...}: {
  networking.networkmanager.enable = true;
  
  networking.hostName = "vhost-dev";
  
  networking.firewall.allowedTCPPorts = [ 22 443 ];

	networking.interfaces.enp2s0.useDHCP = false;
	networking.interfaces.enp2s0.ipv4.addresses = [
		{
			address = "192.168.1.101";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp0s31f6.useDHCP = false;
	networking.interfaces.enp0s31f6.ipv4.addresses = [
		{
			address = "192.168.1.102";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp23s0f0.useDHCP = false;
	networking.interfaces.enp23s0f0.ipv4.addresses = [
		{
			address = "192.168.1.103";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp23s0f1.useDHCP = false;
	networking.interfaces.enp23s0f1.ipv4.addresses = [
		{
			address = "192.168.1.104";
			prefixLength = 24;
		}
	];

	# the network relies on time...

  # TIME
  time.timeZone = "America/Phoenix";
  
}
