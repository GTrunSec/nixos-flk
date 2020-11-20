{ config, lib, pkgs, ... }:

{
  imports = [ ./ghcide-nix.nix
              ./ros.nix
              ./nsm-data-analysis.nix
            ];
}
