{
  self,
  inputs,
  ...
}: {
  nixpkgs = import ./nixpkgs.nix {inherit self inputs;};
  latest = {};
  unstable = {};
}
