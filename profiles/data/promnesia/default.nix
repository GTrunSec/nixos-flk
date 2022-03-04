{
  config,
  lib,
  pkgs,
  ...
}: let
  readConfig = builtins.readFile ./config.py;

  configFile = pkgs.writeScript "config.py" readConfig;

  watcherPath = "/home/gtrun/Dropbox/org-notes/braindump";
in {
  systemd.user.services.promnesia = {
    description = "promnesia Daemon";
    wantedBy = ["graphical-session.target"];
    preStart = ''
      ${pkgs.promnesia}/bin/promnesia index --config ${configFile}
    '';
    serviceConfig = {
      ExecStart = ''
        ${pkgs.promnesia}/bin/promnesia serve
      '';
      Restart = "on-failure";
    };
  };

  systemd.user.paths.promnesia-watcher = {
    wantedBy = ["promnesia.service"];
    pathConfig = {
      PathChanged = [watcherPath];
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
}
