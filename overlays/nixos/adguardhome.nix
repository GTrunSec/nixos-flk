final: prev: {
  adguardhome = prev.adguardhome.overrideAttrs (
    o: {
      inherit (prev.sources.adguardhome) pname version src;
    }
  );
} #// prev.lib.optionalAttrs true {}
