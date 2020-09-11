{ config, lib, pkgs, ... }:

{
  services.promnesia = {
    enable = true;
    config = (builtins.readFile ./config.py);
    watcherPath = "/home/gtrun/Dropbox/org-notes";
  };
}
