{ config, lib, pkgs, ... }:

{
  services.miniflux = {
    enable = true;
  };
}
