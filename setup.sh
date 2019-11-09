#!/bin/sh
# Kill all docker containers
docker kill $(docker ps -q)
# Remove pid
if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

# Setup
source ./aliases.sh
build
rails db:drop
rails db:create

# Install pgcrypto to generate uuid
# psql -h localhost -d development -U postgres -c 'create extension "pgcrypto";'
ridgepole -c config/database.yml -E development --apply -f db/Schemafile --allow-pk-change
rails db:seed
