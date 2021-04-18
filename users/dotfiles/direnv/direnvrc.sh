if [ "$(uname -r)" == "NixOS" ]; then
  source /run/current-system/sw/share/nix-direnv/direnvrc
elif [ "$(uname)" == "Darwin" ]; then
  source $HOME/.nix-direnv/direnvrc
fi
