#!/bin/bash
set -e

WORKSPACE="$(cat workspace)"
PROJECT="$(cat project)"
PAT="$(cat pat)"

if [ "$1" ]; then
  curl -X DELETE "https://app.asana.com/api/1.0/webhooks/$1" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $PAT"
else
  echo "usage:"
  echo "  $0 <webhook-gid>"
  echo
  echo "Use list_webhooks.sh to obtain your <webhook-gid>."
  exit 1
fi
