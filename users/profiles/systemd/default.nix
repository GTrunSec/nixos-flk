{
  config,
  lib,
  pkgs,
  ...
}: {
  systemd.user.startServices = true;
}
