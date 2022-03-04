#credit: https://github.com/akoppela/.dotfiles/blob/95fc955a2f05390481bf56b01f2ebddae826a786/nix/overlay/apps.nix
{
  stdenv,
  lib,
  fetchurl,
  undmg,
  ...
}: {
  pname,
  version,
  src,
  postInstall ? "",
  sourceRoot ? ".",
  extraBuildInputs ? [],
  ...
}:
stdenv.mkDerivation
{
  inherit src pname version;

  buildInputs = [undmg] ++ extraBuildInputs;

  sourceRoot = sourceRoot;

  phases = [
    "unpackPhase"
    "installPhase"
  ];

  installPhase = let
    appname = lib.removeSuffix "-darwin" pname;
  in
    ''
      runHook preInstall

      mkdir -p "$out/Applications"
      cp -r "${appname}.app" "$out/Applications/${appname}.app"
    ''
    + postInstall;

  meta = {
    platforms = lib.platforms.darwin;
  };
}
