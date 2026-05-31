#!/bin/sh
set -e
echo "==> Running DB migrations..."
bundle exec rails db:chatwoot_prepare || true
echo "==> Starting Chatwoot web server..."
exec bundle exec rails server -p ${PORT:-3000} -b 0.0.0.0
