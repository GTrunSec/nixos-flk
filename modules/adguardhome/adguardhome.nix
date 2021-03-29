{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.adguardhome;
  adguardhomeSettingsYml = pkgs.writeText "adguardhome.yaml" cfg.extraSettings;

  adguardhomeSettingsDir = pkgs.runCommand "adguardhome-settings"
    {
      inherit adguardhomeSettingsYml;
      preferLocalBuild = true;
    } ''
    mkdir -p $out
    ln -s $adguardhomeSettingsYml $out/adguardhome.yaml
  '';
in
{
  options.services.adguardhome = {
    enable = mkEnableOption "adguardhome";
    home = mkOption {
      type = types.str;
      default = "/var/lib/adguardhome";
      description = "Storage path of nextcloud.";
    };

    listenAddress = mkOption {
      type = types.str;
      default = "127.0.0.1";
      description = "Address on which to start webserver.";
    };

    port = mkOption {
      type = types.str;
      default = "9002";
      description = "Port on which to start webserver.";
    };

    package = mkOption {
      type = types.package;
      default = pkgs.adguardhome;
      defaultText = "pkgs.adguardhome";
      example = literalExample "pkgs.adguardhome";
      description = "Adguardhome package to use.";
    };

    extraSettings = mkOption {
      type = types.lines;
      default = import ./AdGuardHome.yaml { };
      description = "Extra Logstash settings in YAML format.";
      example = ''
        dns:
         port: 53
      '';
    };
  };

  config = mkIf cfg.enable {
    systemd.services.adguardhome = with pkgs; {
      description = "Adguardhome Daemon";
      after = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];

      script = ''
        exec ${cfg.package}/bin/adguardhome -h ${cfg.listenAddress} -p ${cfg.port} -w ${cfg.home} --pidfile ${cfg.home}/pid -l ${cfg.home}/logs
      '';

      serviceConfig = {
        User = "root";
        RuntimeDirectory = "adguardhome";
        CacheDirectory = "adguardhome";
        StateDirectory = "adguardhome";
        SyslogIdentifier = "adguardhome";
        PrivateTmp = true;
        CapabilityBoundingSet = "CAP_NET_BIND_SERVICE CAP_NET_RAW";
      };
    };
  };
}
