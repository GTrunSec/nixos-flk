{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
  ];
}
