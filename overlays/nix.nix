final: prev: {
  # nix-dram = prev.nix-dram.overrideAttrs (old: {
  #   patches = (old.patches or [ ]) ++ [
  #     (prev.fetchpatch {
  #       name = "fix-follows.diff";
  #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nix/pull/4641.patch";
  #       sha256 = "sha256-nyLMSltS9XjNaF446M5yV/o08XtZkYbU7yMVnqYERts=";
  #     })
  #   ];
  # });
  # nixFlakes = prev.nixFlakes.overrideAttrs (o: rec{
  #   patches = (o.patches or [ ]) ++ [
  #     (prev.fetchpatch {
  #       name = "fix-follows.diff";
  #       url = "https://github.com/CitadelCore/nix/commit/cfef23c040c950222b3128b9da464d9fe6810d79.diff";
  #       sha256 = "sha256-KpYSX/k7FQQWD4u4bUPFOUlPV4FyfuDy4OhgDm+bkx0=";
  #     })
  #   ];
  # });
}
