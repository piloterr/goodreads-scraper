#!/usr/bin/env bash
# Goodreads Book API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./book.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/goodreads/book" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=44767458
