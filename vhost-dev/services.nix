{...}: {
  services = {
    openssh = {
      enable = true;
      settings.PermitRootLogin = "yes";
      settings.PasswordAuthentication = true;
    };
    xrdp = {
      enable = true;
      defaultWindowManager = "gnome-session";
      openFirewall = true;
    };
  };
}
