{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.promnesia;
  configFile = pkgs.writeScript "config.py" cfg.config;
  PreShell = pkgs.writeScript "preRun-promnesia" ''
    if [ ! -d "$HOME/.local/share/promnesia.sqlite" ];then
       ${cfg.package}/bin/promnesia index --config ${configFile}
       fi
  '';
in {
  options.services.promnesia = {
    enable = mkOption {
      description = "Whether to enable promnesia.";
      default = false;
      type = types.bool;
    };

    watcherPath = mkOption {
      type = types.path;
      default = "";
      description = ''
        if this path modified that will restart promnesia service automaticlly.
      '';
    };

    dbPath = mkOption {
      type = types.path;
      default = "";
      description = ''
        sqlite directory for promnesia
      '';
    };
    config = mkOption {
      description = "write resource to config.py";
      default = ''
      '';
      type = types.str;
    };

    package = mkOption {
      description = "promnesia package to use.";
      default = pkgs.promnesia;
      type = types.package;
    };
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    systemd.user.services.promnesia =
      {
        description = "promnesia Daemon";
        preStart = ''
          ${pkgs.bash}/bin/bash ${PreShell}
        '';
        serviceConfig = {
          ExecStart = mkIf cfg.enable ''
            ${cfg.package}/bin/promnesia serve
          '';
          Restart = "always";
        };
      }
      // optionalAttrs cfg.enable {wantedBy = ["default.target"];};

    systemd.user.paths.promnesia-watcher = {
      wantedBy = ["promnesia.service"];
      pathConfig = {
        PathModified = cfg.watcherPath;
        Unit = "promnesia-restarter.service";
      };
    };
    systemd.user.services.promnesia-restarter = {
      serviceConfig.Type = "oneshot";
      wantedBy = ["promnesia.service"];
      script = ''
        systemctl --user restart promnesia.service
      '';
    };
  };
}
