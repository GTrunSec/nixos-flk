{ self, inputs, ... }:
with inputs;
with inputs.nixos;
{
  nixos = import ./nixos { inherit self inputs; };
  latest = { };
}
