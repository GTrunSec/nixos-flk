{
  hmUsers,
  config,
  pkgs,
  ...
}: let
  user = builtins.baseNameOf ./.;
in {
  home-manager.users = {inherit (hmUsers) admin;};

  networking.firewall = {
    allowedTCPPorts = [8888 8889];
    allowedUDPPorts = [8888 8889];
  };

  sops.secrets."users/${user}".neededForUsers = true;

  #Unstbale issue
  security.sudo.wheelNeedsPassword = false;

  users.users.admin = {
    home = "/home/admin";
    passwordFile = config.sops.secrets."users/${user}".path;
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "pulse"
      "sound"
      "libvirtd"
      "video"
      "docker"
    ];
    # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    uid = 1000;
    openssh.authorizedKeys.keys = [];
  };
}
