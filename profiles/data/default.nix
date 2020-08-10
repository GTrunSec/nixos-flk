{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rocksdb
    sqlite
  ];
}
