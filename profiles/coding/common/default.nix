{pkgs, ...}: {
  imports = [];
  environment.systemPackages = with pkgs; [
    cmake
    sbcl
    tree-sitter
    cue
    clang_11
    gcc
    julia_18-bin
    shfmt
    terraform-lsp
    just
    yaml-language-server
    nodePackages.bash-language-server
  ];
}
