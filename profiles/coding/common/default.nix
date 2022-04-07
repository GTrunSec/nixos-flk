{pkgs, ...}: {
  imports = [];
  environment.systemPackages = with pkgs; [
    cmake
    sbcl
    tree-sitter
    cue
    clang_11
    gcc
    julia_17-bin
    shfmt
    zeekscript
    terraform-lsp
    just
  ];
}