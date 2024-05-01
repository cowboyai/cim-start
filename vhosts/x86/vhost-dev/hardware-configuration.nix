{ config, pkgs, ... }: {
  boot.kernelModules = [ "kvm-intel" ];

  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
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
