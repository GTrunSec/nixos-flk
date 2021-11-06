{ pkgs, ... }:

{
  imports = [
    ./promnesia.nix
    ./miniflux.nix
    ./nextcloud.nix
    ./airflow_db.nix
    #./filestash.nix
    ./cassandra.nix
  ];
  services.redis = {
    enable = true;
  };

  # services.geoipupdate = {
  #   enable = true;
  #   AccountID = "";
  # };

  environment.systemPackages = with pkgs;
    [
      rocksdb
      sqlite
    ];
}
