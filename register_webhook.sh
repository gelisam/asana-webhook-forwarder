#!/bin/bash
set -e

WORKSPACE="498346170860"
PROJECT="1148825139806889"
WEBHOOK="https://gelisam.com/asana-log-collector/webhook.php"
PAT="$(cat pat)"

curl -X POST "https://app.asana.com/api/1.0/webhooks?opt_pretty=true&workspace=$WORKSPACE" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $PAT" \
  -d "resource=$PROJECT" \
  -d "target=$WEBHOOK"

