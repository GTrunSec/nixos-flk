function haskellEnv
  nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"
end