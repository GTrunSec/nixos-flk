{ pkgs, ... }:

{
  imports = [
    ./zeek-deploy.nix
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

  services.threatbus-vast = {
    enable = true;
    settings = builtins.readFile ./config.vast.example.yaml;
  };

  services.vast = {
    enable = true;
    settings = {
      log-file = "/var/lib/vast/server.log";
    };
  };

  programs.dconf.enable = true; #for brim to dfconf service

  services.elasticsearch = {
    enable = true;
    package = pkgs.elasticsearch7;
    extraConf = ''
      '';
  };

}
