{
  self,
  inputs,
} @ args: {
  nixos = import ./nixos.nix args;
  nixos-latest = {};
  nixos-unstable = {};
  darwin-nixpkgs = import ./darwin-nixpkgs.nix args;
}
