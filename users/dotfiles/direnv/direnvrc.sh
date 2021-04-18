#source $HOME/.nix-direnv/direnvrc
#source from https://gist.github.com/mbbx6spp/731076cb8fc620b064b8e5b28fb1c796 
use_flake() {
  watch_file flake.nix
  watch_file flake.lock
  eval "$(nix print-dev-env)"
}

hash_env() {
  if has shasum; then
    for e in "${@}"; do shasum -a 256 "${PWD}/${e}"; done | shasum -a 256 | cut -c -64
  else
    fail "do not have shasum to cache environment"
  fi
}

load_nix() {
  local -r orig_IN_NIX_SHELL="${IN_NIX_SHELL:-}"
  local -ra envhash="${1}"
  local -r envdrv="${envdir}/drv"

  nix-shell --show-trace --run 'direnv dump' > "${envdir}/dump"
  direnv apply_dump "${envdir}/dump" > "${envdir}/vars"

  if [ -z "${orig_IN_NIX_SHELL:-}" ]; then
    unset IN_NIX_SHELL
  else
    export IN_NIX_SHELL="$orig_IN_NIX_SHELL"
  fi

  # persist if hash isn't empty
  if [ ! -z "${hash}" ]; then

    env IN_NIX_SHELL=1 \
      nix-instantiate \
      --add-root "${envdrv}" \
      --indirect "shell.nix" \
      > /dev/null
    nix-store \
      -r $(nix-store --query --references "${envdrv}") \
      --add-root "$(cache_file "${envhash}")/result" \
      --indirect \
      > /dev/null
  fi
}

cache_file() {
  echo "${PWD}/.direnv.d/env-${1}"
}

use_nix() {
  # TODO change list of files that should be watched by direnv to ensure shell consistency at run-time.
  local -ra nixexprs=(flake.nix flake.lock)
  local -r hash="$(hash_env ${nixexprs[@]})"
  local -r envdir="$(cache_file "${hash}")"
  mkdir -p "${envdir}"

  if [ -z "${hash:-}" ]; then
    load_nix "${hash}"
  else
    if [ -e "${PWD}/.direnv.d/env-${hash}/drv" ]; then
      log_status "using cached environment (${hash})"
    else
      load_nix "${hash}"
    fi
  fi

  for e in "${nixexprs[@]}"; do
    watch_file "${e}"
  done
  watch_file "${envdir}/drv"
  watch_file "${envdir}"

  source_env "${envdir}/vars"
}
