{ pkgs, ... }:

{
  imports = [ ./promnesia.nix];
  services.redis = {
    enable = true;
  };
  services.postgresql = {
    enable =  true;
    enableTCPIP = true;
    ensureDatabases = [
      "timesketch"
    ];
    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE "timesketch" WITH LOGIN PASSWORD 'timesketch';
      CREATE DATABASE "timesketch" WITH OWNER "timesketch"
      '';
    ensureUsers = [
      {
      name = "timesketch";
      ensurePermissions."DATABASE timesketch" = "ALL PRIVILEGES";
      ensurePermissions."ALL TABLES IN SCHEMA public" = "ALL PRIVILEGES";
      }
    ];
  };
  environment.systemPackages = with pkgs; [
    rocksdb
    sqlite
  ];
}
