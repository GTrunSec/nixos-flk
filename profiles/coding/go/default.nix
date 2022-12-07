{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    go_1_18
    #overlay
    horcrux
    govet
    #######
    gopls
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
    gomod2nix
    dep
    gosec
    gotests
    gotty
    hugo
    go-bindata
  ];
  environment.variables = {GOROOT = ["${pkgs.go_1_18.out}/share/go"];};
}
