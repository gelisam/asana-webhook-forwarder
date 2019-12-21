#!/bin/bash
set -e

WEBHOOK="https://gelisam.com/asana-log-collector/webhook.php"

curl \
  --header "X-Hook-Signature: something" \
  --header "Content-Type: application/json" \
  --request POST \
  --data @input.json \
  "$WEBHOOK"
