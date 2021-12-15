{ config, lib, pkgs, ... }:

{
  nix = {
    registry = {
      nixpkgs-hardenedlinux = lib.mkForce {
        exact = false;
        from = { id = "nixpkgs-hardenedlinux"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/hardenedlinux/nixpkgs-hardenedlinux"; };
      };
      threatbus2nix = lib.mkForce {
        exact = false;
        from = { id = "threatbus2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/threatbus2nix"; };
      };
      vast2nix = lib.mkForce {
        exact = false;
        from = { id = "vast2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/vast2nix"; };
      };
      zeek2nix = lib.mkForce {
        exact = false;
        from = { id = "zeek2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/zeek2nix"; };
      };
    };
  };
}
