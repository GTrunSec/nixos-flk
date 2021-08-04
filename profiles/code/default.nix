{ pkgs, ... }:
let
  customVscode = (import ./vscode.nix { inherit pkgs; });
in
{
  imports = [
    ./texlive-math.nix
    ./go.nix
    ./lib-dep.nix
    ./c++.nix
    ./node.nix
    #./r.nix
    ./rust.nix
    ./haskell.nix
    ./python.nix
  ];
  environment.systemPackages = with pkgs; [
    customVscode
    gnumake
    cmake
    rnix-lsp
    nixfmt
    nixpkgs-fmt
    sbcl
    beautysh
    tree-sitter
  ];
}
