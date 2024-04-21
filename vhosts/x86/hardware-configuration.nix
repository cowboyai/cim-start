{ config, pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-intel" ]; #we only use intel here, for amd use "kvm-amd" 

  networking.hostName = "vhost-dev";
  networking.firewall.allowedTCPPorts = [ 22 443 ];
	networking.interfaces.enp2s0.useDHCP = false;
	networking.interfaces.enp2s0.ipv4.addresses = [
		{
			address = "192.168.100.2";
			prefixLength = 29;
		}
	];

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;
  services.qemuGuest.enable = true;

	fileSystems."/boot" = {
		device = "/dev/disk/by-label/boot";
		fsType = "vfat";
	};

	boot.initrd.luks.devices.root = {
		device = "/dev/disk/by-label/root";

		# WARNING: Leaks some metadata, see cryptsetup man page for --allow-discards.
		allowDiscards = true;

		# Set your own key with:
		# cryptsetup luksChangeKey /dev/disk/by-label/root --key-file=/dev/zero --keyfile-size=1
		# You can then delete the rest of this block.
		keyFile = "/dev/zero";
		keyFileSize = 1;

		fallbackToPassword = true;
	};

	fileSystems."/" = {
		device = "/dev/mapper/root";
		fsType = "ext4";
	};
}
