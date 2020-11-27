{ pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    tcpreplay
    suricata
    #home
    sudo-pair
    btest
    brim
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

  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.hardenedlinux-zeek;
    privateScript = ''
    @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/zeek-query.zeek    
    '';
  };

}
