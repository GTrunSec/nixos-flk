final: prev: {
  virtualbox = prev.virtualbox.overrideAttrs (o: {
    # patches = o.patches ++ [
    #   ../local/108285.patch
    # ];
  });
}
