{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
  ] ++ (with rust-bin.stable.latest; [
    default
  ]);
}
