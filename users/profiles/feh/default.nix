{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  programs.feh = {
    enable = true;
  };
}
