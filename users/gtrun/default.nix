{
  hmUsers,
  config,
  pkgs,
  ...
}: let
  user = builtins.baseNameOf ./.;
in {
  home-manager.users = {inherit (hmUsers) gtrun;};

  networking.firewall = {
    allowedTCPPorts = [8888 8889];
    allowedUDPPorts = [8888 8889];
  };

  sops.secrets."users/${user}".neededForUsers = true;

  #Unstbale issue
  security.sudo.wheelNeedsPassword = false;

  users.users.gtrun = {
    home = "/home/gtrun";
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDI2uDp51HMggnfz4Zn5ky4gb/XVdQiJR7pZyb/LcCLx macOSdeMBP.attlocal.net-gtrun-14-05-2021"
    ];
  };
  services.lorri.enable = true;
}
