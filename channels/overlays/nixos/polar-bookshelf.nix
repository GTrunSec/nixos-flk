final: prev: {
  polar-bookshelf = prev.polar-bookshelf.overrideAttrs (
    o: rec {
      inherit (prev.sources.polar-bookshelf) pname version src;
      buildInputs =
        (o.buildInputs or [])
        ++ (
          with prev; [
            libdrm
            mesa
          ]
        );
    }
  );
}
