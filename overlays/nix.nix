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
  # nixUnstable = prev.nixUnstable.overrideAttrs (o: rec{
  #   patches = (o.patches or [ ]) ++ [
  #     (prev.fetchpatch {
  #       name = "fix-follows.diff";
  #       url = "https://patch-diff.githubusercontent.com/raw/NixOS/nix/pull/4641.patch";
  #       sha256 = "sha256-0xNgbyWFmD3UIHPNFrgKiSejGJfuVj1OjqbS1ReLJRc=";
  #     })
  #   ];
  # });
}
