{ config
, pkgs
, ...
}:
let
  devFlake = builtins.getFlake (toString ../modules/shells/rust-leptos);
  system = pkgs.system;
  devShell = devFlake.devShells.${system}.default;
in
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.qemuGuest.enable = true;

  networking = {
    hostName = "cim-dev";
    search = [ "cim.thecowboy.ai" ];
  };

  security.sudo.wheelNeedsPassword = false;
  security.polkit.enable = true;

  users.mutableUsers = true;
  users.users.cim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
      nats-server
      natscli
      nsc
      wash-cli
    ];
    hashedPassword = "$y$j9T$67lOar4UwWjRxaTypZV1W0$dPrgYqUJppfVUf/ugSTwVp5brl2y94B.2h060m495sC";
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai" ];
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    direnv.enable = true;
    git.enable = true;
    zsh = {
      enable = true;
      enableCompletion = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        format = "$all";
        scan_timeout = 10;
      };
    };
  };

  systemd.services."container@${config.networking.hostName}".serviceConfig = {
    DeviceAllow = [
      "char-nvidia-frontend rwm"
      "/dev/nvidia0 rwm"
      "/dev/nvidiactl rwm"
      "/dev/nvidia-modeset rwm"
      "/dev/nvidia-uvm rwm"
      "/dev/nvidia-uvm-tools rwm"
    ];
    BindPaths = [
      "/dev/nvidia0"
      "/dev/nvidiactl"
      "/dev/nvidia-modeset"
      "/dev/nvidia-uvm"
      "/dev/nvidia-uvm-tools"
    ];
  };

  environment.systemPackages = devShell.buildInputs;
  environment.shellInit = devShell.shellHook or "";

  system.stateVersion = "24.05";
}
