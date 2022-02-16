{ lib }:
lib.makeExtensible (
  self: {
    hosts = import ./hosts { inherit lib; };
  }
)
