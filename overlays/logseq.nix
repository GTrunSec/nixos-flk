final: prev: {
  logseq = prev.logseq.overrideAttrs (_: rec{
    inherit (prev.sources.logseq) pname version src;
  });
}
