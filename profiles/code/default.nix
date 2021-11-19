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
    ./nix.nix
  ];
  environment.systemPackages = with pkgs; [
    customVscode
    gnumake
    cmake
    sbcl
    beautysh
    tree-sitter
    cue
  ];
}
