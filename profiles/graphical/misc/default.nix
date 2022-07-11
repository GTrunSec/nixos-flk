{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.gnome.seahorse];
  services.gnome.gnome-keyring.enable = true;
}
