{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cabal-install
    haskellPackages.hlint
    haskellPackages.hoogle
    (haskell-language-server.override { supportedGhcVersions = [ "884" "8103" ]; })
    #(haskell.lib.dontCheck haskellPackages.intero)
    haskellPackages.alex
    haskellPackages.haskell-language-server
    haskellPackages.happy
    haskellPackages.zlib
    #haskellPackages.stack
    haskellPackages.stylish-haskell
    ghc
  ];

}
