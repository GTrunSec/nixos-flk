#!/usr/bin/env bash

# edit file with emacsclient directly or as pipe
# https://emacs-china.org/t/shell-emacs/17964
# SEE https://www.emacswiki.org/emacs/EmacsPipe
# pipe stdin to emacsclient like vim with  "| et - "
if [[ $1 == "-" ]]; then
  TMP="$(mktemp /tmp/et-stdin-XXX)"

  # SEE https://superuser.com/a/380778
  sed 's/\x1b\[[0-9;]*[a-zA-Z]//g' | cat >"$TMP"

  [ ! -s "$TMP" ] && rm "$TMP" && exit 0
fi

emacsclient -u -e '(server-running-p)' 2>/dev/null || emacs --daemon

if [[ $1 == "-" ]]; then
  emacsclient -q -t "$TMP"
else
  emacsclient -q -t "$@"
fi
