{}:
''
  nix-env --delete-generations 7d
  home-manager expire-generations 7d
  sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 7d
  nix-collect-garbage -d
  nix optimise-store 2>&1 | sed -E 's/.*'\'''(\/nix\/store\/[^\/]*).*'\'''/\1/g' | uniq | sudo parallel 'nix-store --repair-path {}'
  #nix-store --optimize
''
