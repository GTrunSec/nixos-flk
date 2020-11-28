{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.services.filestash;
  dockerComposeFile = pkgs.writeText "docker-compose.yml" (import ./docker-compose.nix { httpPort = cfg.httpPort; host = cfg.host;});
in
{
  options.services.filestash = {
    enable = mkOption { type = types.bool; default = false; };
    image = mkOption { type = types.str; };
    httpPort = mkOption { type = types.int; default = 8334; };
    host = mkOption { type = types.str; default = "0.0.0.0"; };
   };

  config = mkIf cfg.enable {
    systemd.services.filestash = {
      enable   = true;
      wantedBy = [ "multi-user.target" ];
      requires = [ "docker.service" ];
      environment = { COMPOSE_PROJECT_NAME = "filestash"; };
      serviceConfig = mkMerge [
        {
          ExecStart = "${pkgs.docker_compose}/bin/docker-compose -f '${dockerComposeFile}' up --build";
          ExecStop  = "${pkgs.docker_compose}/bin/docker-compose -f '${dockerComposeFile}' stop";
          Restart   = "always";
        }
      ];
    };
  };
}
