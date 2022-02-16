{
  pkgs,
  lib,
  sources,
  ...
}:
with pkgs; with lib; let
  whitelist = concatStringsSep "|" [ ".*pirate(bay|proxy).*" ];

  blacklist = concatStringsSep ''
    0.0.0.0 ''
  [
    "# auto-generated: must be first"

    # starts here
  ];
in
  stdenv.mkDerivation
  {
    inherit (sources.StevenBlack-hosts) src pname version;

    nativeBuildInputs = [ gnugrep ];

    installPhase = ''
      mkdir -p $out/etc

      # filter whitelist
      grep -Ev '(${whitelist})' hosts > $out/etc/hosts

      # filter blacklist
      cat << EOF >> $out/etc/hosts
      ${blacklist}
      EOF
    '';
  }
