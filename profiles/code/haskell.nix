{ pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        cabal-install
        haskellPackages.hlint
        haskellPackages.hoogle
        #(haskell.lib.dontCheck haskellPackages.intero)
        haskellPackages.alex
        haskellPackages.happy
        haskellPackages.zlib
        #haskellPackages.stack
        haskellPackages.stylish-haskell
        ghc
    ];

}
