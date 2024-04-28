{ config, pkgs, ... }: {
  boot.kernelModules = [ "kvm-intel" ]; #we only use intel here, for amd use "kvm-amd" 

  networking.hostName = "vhost-dev";
  networking.firewall.allowedTCPPorts = [ 22 443 ];
	# networking.interfaces.enp2s0.useDHCP = false;
	# networking.interfaces.enp2s0.ipv4.addresses = [
	# 	{
	# 		address = "192.168.100.2";
	# 		prefixLength = 29;
	# 	}
	# ];

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
  };
  
  # allow build arm images
  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
		systemd-boot.enable = false;
    grub.enable = true;
    grub.devices = [ "nodev" ];
    grub.efiSupport = true;
  };

  zramSwap.enable = true;

	fileSystems."/boot" = {
		device = "/dev/disk/by-label/boot";
		fsType = "vfat";
	};

	fileSystems."/" = {
		device = "/dev/disk/by-label/root";
		fsType = "ext4";
	};

	fileSystems."/data" = {
		device = "/dev/disk/by-label/data";
		fsType = "ext4";
	};

}
