{lib}:
lib.makeExtensible (
  self: {
    hosts = import ./hosts {inherit lib;};
    overlayNullProtector = import ./overlay-null-protector.nix;
  }
)
