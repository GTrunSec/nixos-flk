final: prev: {
  drawio = prev.drawio.overrideAttrs (o: rec{
    inherit (prev.sources.drawio) pname version src;
  });
}
