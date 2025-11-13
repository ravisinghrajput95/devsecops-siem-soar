#!/bin/bash
FILE="$1"

if [ -z "$SIEM_URL" ]; then
  echo "Set SIEM_URL first!"
  exit 1
fi

curl -X POST "$SIEM_URL" \
  -H "Content-Type: application/json" \
  --data-binary @"$FILE"
