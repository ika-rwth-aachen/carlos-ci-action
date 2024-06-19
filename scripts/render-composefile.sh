#!/bin/bash

set -eo pipefail

main() {
  if [[ $# -eq 0 ]]; then
    >&2 echo "No arguments. Provide at least one valid Composefile to start the rendering."
    exit 1
  fi

  local compose_basefile="$1" 
  local compose_mergefile="$2"
  local compose_outfile="${RENDERCOMPOSE_OUTFILE:-"$compose_basefile"}" # If no outfile provided, do in-place merging
    
  local compose_fileflags="-f $compose_basefile"
  if [[ ! -z "$compose_mergefile" ]]; then
    compose_fileflags+=" -f $compose_mergefile"
  fi

  docker compose $compose_fileflags config -o "$compose_outfile"
}

main "$@"
