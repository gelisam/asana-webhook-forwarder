#!/bin/bash
set -e

WORKSPACE="$(cat workspace)"
PROJECT="$(cat project)"
WEBHOOK="$(cat webhook)"
PAT="$(cat pat)"

curl -X POST "https://app.asana.com/api/1.0/webhooks?opt_pretty=true&workspace=$WORKSPACE" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $PAT" \
  -d "resource=$PROJECT" \
  -d "target=$WEBHOOK"

