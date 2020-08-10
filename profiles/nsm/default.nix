{ pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [
    tcpreplay
    suricata
  ];

  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.zeek;
    privateScript = ''
    @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/zeek-query.zeek
    '';
  };

}
