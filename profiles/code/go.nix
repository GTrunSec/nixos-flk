{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [    go
                                                 #overlay
                                                 horcrux
                                                 govet
                                                 #######
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
                                                 hugo
                                                 go-bindata
                                            ];
    environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
}
