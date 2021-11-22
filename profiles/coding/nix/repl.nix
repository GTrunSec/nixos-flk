# Adapted on 3rd of July 2021 from
# https://github.com/gytis-ivaskevicius/flake-utils-plus/blob/438316a7b7d798bff326c97da8e2b15a56c7657e/lib/repl.nix

{ flakePath, host }:

let

  Flake =
    if builtins.pathExists flakePath
    then builtins.getFlake (toString flakePath)
    else { }
  ;

  Me = Flake.nixosConfigurations.${host} or { };
  Channels = Flake.pkgs.${builtins.currentSystem} or { };

  LoadFlake = path: builtins.getFlake (toString path);

in
{
  inherit
    Channels
    Flake
    LoadFlake
    Me
    ;
}
