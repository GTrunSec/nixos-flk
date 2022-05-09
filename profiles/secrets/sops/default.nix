{
  config,
  lib,
  pkgs,
  ...
}: {
  sops.gnupg.sshKeyPaths = [];
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
}
