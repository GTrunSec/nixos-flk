{ pkgs, ... }:

{
  imports = [ ./promnesia.nix];
  environment.systemPackages = with pkgs; [
    rocksdb
    sqlite
  ];
}
