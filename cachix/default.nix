{ config, lib, pkgs, ... }:

{
  imports = [ ./ghcide-nix.nix
              ./ros.nix
            ];
}
