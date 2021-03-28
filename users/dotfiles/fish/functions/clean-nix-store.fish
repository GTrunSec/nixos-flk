nix-env --delete-generations 7d
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 7d
nix-collect-garbage
nix-store --optimize
