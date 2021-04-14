{ pkgs, srcs, ... }:
let
  inherit (builtins) concatStringsSep;
  inherit (pkgs) fetchFromGitHub stdenv gnugrep;
  inherit (builtins) readFile fetchurl;
  inherit (srcs) StevenBlack-src;

  hosts = stdenv.mkDerivation {
    name = "hosts";

    src = fetchFromGitHub {
      owner = "StevenBlack";
      repo = "hosts";
      rev = "c202dbda759bb0ab52c68e9f675ccd2ad4b59c3e";
      hash = "sha256-etXlrCUOBU2U/T/lHYOzAtIyLW4k1OXA7Q/+WMvPiZg=";
    };

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
  };

  whitelist = concatStringsSep "|" [ ".*pirate(bay|proxy).*" ];

  blacklist = concatStringsSep ''

    0.0.0.0 ''
    [
      "# auto-generated: must be first"

      # starts here
    ];

in
{ networking.extraHosts = readFile "${hosts}/etc/hosts"; }
