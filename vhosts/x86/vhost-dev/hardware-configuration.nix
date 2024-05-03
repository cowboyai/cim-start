{ config, pkgs, ... }: {
  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  boot.initrd = {
    availableKernelModules = [ "ahci" "xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "kvm-intel" "iwlwifi" ];
    systemd.enable = true;
  };
  
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

  # 2nd stage modules
  boot.kernelModules = [ ];

  # mostly for network support
  hardware.enableRedistributableFirmware = true;

}
