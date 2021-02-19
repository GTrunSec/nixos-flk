{ pkgs, ... }:

{
  imports = [
    ./promnesia.nix
    ./miniflux.nix
    ./nextcloud.nix
    ./postgresql.nix
    ./filestash.nix
  ];
  services.redis = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    rocksdb
    sqlite

    nteract
  ];
}
