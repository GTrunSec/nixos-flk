{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.htop.enable = true;
  programs.bat.enable = true;
  programs.broot.enable = true;
}
