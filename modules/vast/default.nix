{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.services.vast;
  configFile = pkgs.writeText "vast.conf" (
    builtins.toJSON {
      vast = {
        endpoint = "${toString cfg.endpoint}";
        db-directory = "/var/lib/vast";
      } // cfg.settings;
    });
in
{
  options =
    {
      services.vast = {
        enable = mkOption {
          type = types.bool;
          default = false;
          description = ''
            Whether to enable vast endpoint
          '';
        };

        settings = mkOption {
          type = types.attrsOf types.anything;
          default = { };
        };

        package = mkOption {
          type = types.package;
          default = pkgs.vast;
          description = "The vast package.";
        };

        endpoint = mkOption {
          type = types.str;
          default = "127.0.0.1:4000";
          example = "localhost:4000";
          description = ''
            The host and port to listen at and connect to.
          '';
        };
      };
    };

  config = mkIf cfg.enable {
    users.users.vast =
      { isSystemUser = true; group = "vast"; };

    users.groups.vast = { };

    systemd.services.vast = {
      description = "Visibility Across Space and Time";

      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [
        "network-online.target"
        #"zeek.service
      ];

      confinement = {
        enable = true;
        binSh = null;
        #fullUnit = true;
      };


      script = ''
        exec ${cfg.package}/bin/vast --config=${configFile} start
      '';

      serviceConfig = {
        Restart = "always";
        RestartSec = "10";
        ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID && ${pkgs.coreutils}/bin/rm vast.db/pid.lock";
        User = "vast";
        PrivateUsers = true;
        DynamicUser = mkForce false;
        WorkingDirectory = "/var/lib/vast";
        ReadWritePaths = "/var/lib/vast";
        RuntimeDirectory = "vast";
        CacheDirectory = "vast";
        StateDirectory = "vast";
        SyslogIdentifier = "vast";
        PrivateTmp = true;
        ProtectHome = true;
      };
    };
  };
}
