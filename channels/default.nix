{
  self,
  inputs,
  ...
}: {
  nixos = import ./nixos.nix {inherit self inputs;};
  latest = {};
  unstable = {};
}
