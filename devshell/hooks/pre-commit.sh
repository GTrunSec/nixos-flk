#!/usr/bin/env bash

if git rev-parse --verify HEAD >/dev/null 2>&1; then
  against=HEAD
else
  # Initial commit: diff against an empty tree object
  against=$(${git}/bin/git hash-object -t tree /dev/null)
fi

diff="git diff-index --name-only --cached $against --diff-filter d"

nix_files=($($diff -- '*.nix'))
all_files=($($diff))

# Format staged nix files.
if [[ -n ${nix_files[@]} ]]; then
  nixpkgs-fmt "${nix_files[@]}" &&
    git add "${nix_files[@]}"
fi
