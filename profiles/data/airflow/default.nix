{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    ensureDatabases = [
      "airflow_db"
    ];
    ensureUsers = [
      {
        name = "airflow_user";
        ensurePermissions."DATABASE airflow_db" = "ALL PRIVILEGES";
      }
    ];
  };
}
