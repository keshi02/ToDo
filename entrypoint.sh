#!/bin/bash
set -e

rm -f /todo/tmp/pids/server.pid

bundle exec rails db:migrate
bundle exec rake assets:precompile

exec "$@"
