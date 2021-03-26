{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustc
    cargo
    rustfmt
    rustup
    rls
  ];
}
