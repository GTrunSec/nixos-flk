{ config, lib, pkgs, ... }:

{
  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.zeek.override {
      KafkaPlugin = true;
      PostgresqlPlugin = true;
      Http2Plugin = true;
      Ikev2Plugin = true;
      CommunityIdPlugin = true;
      ZipPlugin = true;
      PdfPlugin = true;
      SpicyPlugin = false;
    };
    privateScript = ''
      @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/zeek-query.zeek
      @load /home/gtrun/project/hardenedlinux-zeek-script/scripts/log-passwords.zeek
    '';
  };
}
