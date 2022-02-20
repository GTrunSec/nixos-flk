{home-manager}: ''
  nix-env --delete-generations 3d
  ${home-manager} expire-generations 3d
  sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 3d
  nix-collect-garbage -d
  nix optimise-store 2>&1 | sed -E 's/.*'\'''(\/nix\/store\/[^\/]*).*'\'''/\1/g' | uniq | sudo parallel 'nix-store --repair-path {}'
  #nix-store --optimize
''
