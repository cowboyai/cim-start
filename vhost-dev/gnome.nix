{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = false;
    desktopManager.gnome.enable = true;
    videoDrivers = ["nvidia"];
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.gnome.gnome-remote-desktop.enable = true;
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.adwaita-icon-theme
    gnomeExtensions.appindicator
    gnome.gnome-remote-desktop
    remmina
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    telegram-desktop
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
    dbus.packages = [pkgs.gcr];
    power-profiles-daemon.enable = true;
    geoclue2.enable = true;
    udev = {
      packages = with pkgs; [gnome.gnome-settings-daemon];
    };
    printing.enable = true;
  };

  services.gnome = {
    gnome-keyring.enable = true;
  };
  # turn off power management for this server
  services.xserver.displayManager.gdm.autoSuspend = false;
}
