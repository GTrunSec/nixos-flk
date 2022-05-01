{
  self,
  inputs,
  ...
}: {
  nixos = import ./nixos.nix {inherit self inputs;};
  nixos-latest = {};
  nixos-unstable = {};
}
