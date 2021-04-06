{ pkgs, ... }:

{
  imports = [
    ./zeek-deploy.nix
    ./vast-threatbus.nix
  ];

  environment.systemPackages = with pkgs; [
    suricata
    #home
    sudo-pair
    #btest
    #brim
    tcpdump
  ];

  services.dbus = {
    enable = true;
  };

  programs.dconf.enable = true; #for brim to dfconf service

  services.elasticsearch = {
    enable = true;
    package = pkgs.elasticsearch7;
    extraConf = ''
      '';
  };

}
