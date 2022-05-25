# Adapted on 3rd of July 2021 from
# https://github.com/gytis-ivaskevicius/flake-utils-plus/blob/438316a7b7d798bff326c97da8e2b15a56c7657e/lib/repl.nix
{flakePath}: let
  Flake =
    if builtins.pathExists flakePath
    then
      (import (fetchTarball {
        url = "https://github.com/edolstra/flake-compat/archive/b4a34015c698c7793d592d66adbab377907a2be8.tar.gz";
        sha256 = "1qc703yg0babixi6wshn5wm2kgl5y1drcswgszh4xxzbrwkk9sv7";
      }) {src = toString flakePath;})
      .defaultNix
    else {};

  Channels = Flake.pkgs.${builtins.currentSystem} or <nixpkgs>;

  LoadFlake = path: builtins.getFlake (toString path);
in {
  inherit
    Channels
    Flake
    LoadFlake
    ;
}
