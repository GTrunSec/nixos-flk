final: prev:
with final.lib; {
  logseq-darwin = installApp rec {
    inherit (final.sources.logseq-darwin) pname version src;
  };
  polar-darwin = installApp rec {
    inherit (final.sources.polar-darwin) pname version src;
  };
  kitty-darwin = installApp rec {
    inherit (final.sources.kitty-darwin) pname version src;
  };
}
