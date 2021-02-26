{ config, lib, pkgs, ... }:

{
  imports = [
    ./ros.nix
    ./nsm-data-analysis.nix
  ];
}
