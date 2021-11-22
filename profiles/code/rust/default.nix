{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (rust-bin.stable.latest.default.override { extensions = [ "rust-src" ]; })
    rust-bin.nightly.latest."rust-analyzer-preview"
  ];
}
