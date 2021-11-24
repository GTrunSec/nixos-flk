{ pkgs, ... }:
{
  imports = [ ];
  environment.systemPackages = with pkgs; [
    cmake
    sbcl
    beautysh
    tree-sitter
    cue
    gcc
    clang
  ];
}
