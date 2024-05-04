# network.nix
{...}: {
	networking.wireless.enable = false;

  networking.networkmanager.enable = true;
  
  networking.hostName = "vhost-dev";
	
	networking.defaultGateway = "192.168.1.1";

	networking.nameservers = [ "192.168.1.1" "1.1.1.1" ];

  networking.firewall.allowedTCPPorts = [ 22 443 ];

	networking.interfaces.enp0s31f6.useDHCP = false;
	networking.interfaces.enp0s31f6.ipv4.addresses = [
		{
			# mac: 74:86:e2:10:a1:fa
			address = "192.168.1.100";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp2s0.useDHCP = false;
	networking.interfaces.enp2s0.ipv4.addresses = [
		{
			# mac: 74:86:e2:10:9f:6d
			address = "192.168.1.101";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp23s0f0.useDHCP = false;
	networking.interfaces.enp23s0f0.ipv4.addresses = [
		{
			# mac: b4:96:91:cd:04:c4
			address = "192.168.1.102";
			prefixLength = 24;
		}
	];

	networking.interfaces.enp23s0f1.useDHCP = false;
	networking.interfaces.enp23s0f1.ipv4.addresses = [
		{
			# mac: b4:96:91:cd:04:c6
			address = "192.168.1.103";
			prefixLength = 24;
		}
	];

	# the network relies on time...

  # TIME
  time.timeZone = "America/Phoenix";
  
}
