{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rust-analyzer
  ] ++ (with rust-bin.nightly.latest; [
    rust-analysis
  ]);
}
