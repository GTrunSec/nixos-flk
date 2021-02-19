{ pkgs, ... }:
let
  ghcide-nix = import
    (builtins.fetchGit {
      url = https://github.com/cachix/ghcide-nix;
      rev = "e238591da2b6ebb666851d1e96effb31ce5a9e3a";
      ref = "master";
    })
    { };
in
{
  environment.systemPackages = with pkgs; [
    cabal-install
    haskellPackages.hlint
    haskellPackages.hoogle
    ghcid # Haskell GHCi daemon
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
