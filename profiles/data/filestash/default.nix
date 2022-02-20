{
  config,
  lib,
  pkgs,
  ...
}: {
  services.filestash = {
    enable = false;
  };
}
