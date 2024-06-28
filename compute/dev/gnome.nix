{ config
, pkgs
, lib
, ...
}: {
  boot.kernelModules = [ "nvidia" "nvidia_modeset" ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.spice-vdagentd.enable = true;

  hardware.graphics.enable = true;
  hardware.nvidia.modesetting.enable = true;
  virtualisation.docker.enableNvidia = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.gnome.gnome-remote-desktop.enable = true;
  services.xrdp = {
    enable = true;
    openFirewall = true;
    defaultWindowManager = "${pkgs.gnome.gnome-session}/bin/gnome-session";
  };

  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome.gnome-remote-desktop
    gnome.gnome-session
    remmina
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    virt-manager
    virt-viewer
    telegram-desktop
    xrdp
  ];

  # remove bloatware
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      xterm
    ])
    ++ (with pkgs.gnome; [
      gnome-music
      gnome-terminal
      gnome-contacts
      gnome-initial-setup
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  services = {
    upower.enable = lib.mkForce false;
    dbus.enable = true;
    dbus.packages = [ pkgs.gcr ];
    power-profiles-daemon.enable = true;
    geoclue2.enable = true;
    udev = {
      packages = with pkgs; [ gnome.gnome-settings-daemon ];
    };
    printing.enable = false;
  };

  services.gnome = {
    gnome-keyring.enable = true;
  };
  # turn off power management for this server
  services.xserver.displayManager.gdm.autoSuspend = false;
}
