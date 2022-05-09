{
  config,
  lib,
  pkgs,
  ...
}: {
  services.dropbox = {
    enable = true;
  };
}
