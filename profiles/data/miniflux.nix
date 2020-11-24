{ config, lib, pkgs, ... }:
{
  services.miniflux = {
    enable = true;
    adminCredentialsFile = ../../secrets/miniflux-admin-credentials;
    config.LISTEN_ADDR = "localhost:9000";
  };
}
