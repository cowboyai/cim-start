{ config, pkgs, ... }: {
  boot.kernelModules = [ "kvm-intel" ]; #we only use intel here, for amd use "kvm-amd" 

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ "kvm-intel" ];
  };
  
  # allow build arm images
  #boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  boot.loader = {
    grub.efiSupport = true;
    efi.canTouchEfiVariables = true;
		systemd-boot.enable = false;
    grub.enable = true;
    grub.devices = [ "nodev" ];
  };

  zramSwap.enable = true;

}
