#!/bin/bash
set -e

WORKSPACE="498346170860"
PROJECT="1148825139806889"
WEBHOOK="$1"
PAT="$(cat pat)"

if [ "$1" ]; then
  curl -X DELETE "https://app.asana.com/api/1.0/webhooks/$WEBHOOK" \
    -H "Accept: application/json" \
    -H "Authorization: Bearer $PAT"
else
  echo "usage:"
  echo "  $0 <webhook-gid>"
  echo
  echo "Use list_webhooks.sh to obtain your <webhook-gid>."
  exit 1
fi
