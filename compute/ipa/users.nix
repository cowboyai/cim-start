{
  config,
  pkgs,
  ...
}: {
  users.mutableUsers = true;
  users.users.radius.group = "radius";
  users.groups.radius = {};
  users.users.cim = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "radius"];
    useDefaultShell = false;
    shell = pkgs.zsh;
    packages = with pkgs; [
    ];
    initialPassword = "cim";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDgGW4Y7S8YO3Se/1AK1ZuIaAtxa+sakK4SBv/nixRyJ cim@thecowboy.ai"];
  };
}
