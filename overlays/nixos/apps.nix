final: prev:
let
  installApp = import ../../lib/installApp.nix prev;
in
{
  logseq-darwin = installApp rec {
    inherit (final.sources.logseq-darwin) pname version src;
  };
  polar-darwin = installApp rec {
    inherit (final.sources.polar-darwin) pname version src;
  };
}
