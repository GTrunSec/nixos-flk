{
  pkgs,
  ...
}:
{
  imports = [ ];
  environment.systemPackages = with pkgs; [
    cmake
    sbcl
    beautysh
    tree-sitter
    cue
    clang
    gcc
    julia_17-bin
    shfmt
  ];
}
