{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    go
    gotools
    go_bootstrap
    go-langserver
    gocode
    go-outline
    go-symbols
    go-tools
    gocode-gomod
    godef
    gopkgs
    delve
    golint
    #for nix
    go2nix
    vgo2nix
    dep
    gosec
    gotests
    gotty
  ];
  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
