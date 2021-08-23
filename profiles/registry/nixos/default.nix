{ config, lib, pkgs, ... }:

{
  nix = {
    registry = {
      threatbus2nix = {
        from = { id = "threatbus2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/threatbus2nix"; };
      };
      vast2nix = {
        from = { id = "vast2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/vast2nix"; };
      };
      zeek2nix = {
        from = { id = "zeek2nix"; type = "indirect"; };
        to = { type = "git"; url = "file:///home/gtrun/ghq/github.com/GTrunSec/zeek2nix"; };
      };
    };
  };
}
