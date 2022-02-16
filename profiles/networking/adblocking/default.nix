{
  pkgs,
  lib,
  ...
}:
{ networking.extraHosts = lib.readFile "${pkgs.StevenBlack-hosts}/etc/hosts"; }
