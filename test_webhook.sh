#!/bin/bash
set -e

WEBHOOK="$(cat webhook)"

curl \
  --header "X-Hook-Signature: something" \
  --header "Content-Type: application/json" \
  --request POST \
  --data @input.json \
  "$WEBHOOK"
