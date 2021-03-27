{ lib, ... }:
rec {
  # mapFilterAttrs ::
  #   (name -> value -> bool )
  #   (name -> value -> { name = any; value = any; })
  #   attrs
  mapFilterAttrs = seive: f: attrs:
    lib.filterAttrs
      seive
      (lib.mapAttrs' f attrs);

  # Generate an attribute set by mapping a function over a list of values.
  genAttrs' = values: f: lib.listToAttrs (map f values);

  # Convert a list of file paths to attribute set
  # that has the filenames stripped of nix extension as keys
  # and imported content of the file as value.
  #
  pathsToImportedAttrs = paths:
    let
      paths' = lib.filter (lib.hasSuffix ".nix") paths;
    in
    genAttrs' paths' (path: {
      name = lib.removeSuffix ".nix" (baseNameOf path);
      value = import path;
    });

  concatAttrs = lib.fold (attr: sum: lib.recursiveUpdate sum attr) { };

  # Filter out packages that support given system and follow flake check requirements
  filterPackages = system: packages:
    let
      # Everything that nix flake check requires for the packages output
      filter = (n: v: with v; let platforms = meta.hydraPlatforms or meta.platforms or [ ]; in
        lib.isDerivation v && !meta.broken && builtins.elem system platforms);
    in
      lib.filterAttrs filter packages;
}
