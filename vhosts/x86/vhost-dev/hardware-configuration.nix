{ config, pkgs, ... }: {
  boot.kernelModules = [ "kvm-intel" ];

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  boot.initrd = {
    availableKernelModules = [ "ahci" "xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod" ];
    kernelModules = [ "kvm-intel" ];
    systemd.enable = true;
  };
  
  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

}
