{ config, lib, pkgs, ... }:

{
  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.zeek;
    privateScript = ''
      @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/zeek-query.zeek
      @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/log-passwords.zeek
    '';
  };
}
