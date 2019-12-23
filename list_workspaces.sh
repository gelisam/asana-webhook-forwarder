#!/bin/bash
set -e

PAT="$(cat pat)"

curl -X GET "https://app.asana.com/api/1.0/workspaces?opt_pretty=true" \
  -H "Accept: application/json" \
  -H "Authorization: Bearer $PAT"
