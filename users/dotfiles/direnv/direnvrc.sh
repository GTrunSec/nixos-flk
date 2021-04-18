if [ "$(uname -r)" == "NixOS" ]; then
  source /run/current-system/sw/share/nix-direnv/direnvrc
elif [ "$(uname)" == "Darwin" ]; then
  source $HOME/.nix-direnv/direnvrc
fi

use_flake() {
  watch_file flake.nix
  watch_file flake.lock
  eval "$(nix print-dev-env)"
}
