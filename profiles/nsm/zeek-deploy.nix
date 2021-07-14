{ pkgs, ... }:

{
  services.zeek = {
    enable = true;
    standalone = true;
    interface = "eno1";
    listenAddress = "localhost";
    package = pkgs.zeek-release.override {
      KafkaPlugin = true;
      PostgresqlPlugin = true;
      Http2Plugin = true;
      CommunityIdPlugin = true;
      ZipPlugin = true;
      PdfPlugin = true;
      SpicyPlugin = true;
    };
    privateScript = ''
    '';
  };
}
