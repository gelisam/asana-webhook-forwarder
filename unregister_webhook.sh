#!/bin/bash
set -e

WORKSPACE="$(workspace)"
PROJECT="$(project)"
WEBHOOK="$(webhook)"
PAT="$(cat pat)"

curl -X DELETE "https://app.asana.com/api/1.0/webhooks/$WEBHOOK" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $PAT"
