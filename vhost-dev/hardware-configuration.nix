{
  config,
  pkgs,
  ...
}: {
  # allow qemu/kvm
  virtualisation.libvirtd.enable = true;

  # truen this machine into a router...
  # boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  boot.initrd = {
    availableKernelModules = ["ahci" "xhci_pci" "vmd" "nvme" "usbhid" "usb_storage" "sd_mod" "sr_mod"];
    kernelModules = ["kvm-intel"];
    systemd.enable = true;
  };

  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  zramSwap.enable = true;

  # 2nd stage modules
  boot.kernelModules = [];

  # mostly for network support
  hardware.enableRedistributableFirmware = true;

  # sound
  hardware.pulseaudio.enable = true;
  sound.enable = true;
}
