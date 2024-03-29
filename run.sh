#!/usr/bin/env bash

# Start MongoDB
mongod --fork --logpath /var/log/mongodb/mongodb.log
sleep 5

# Start RabbitMQ
rabbitmq-server -detached
sleep 5

# Start Minion
cd $MINION_BACKEND
scripts/minion-backend-api runserver -a 0.0.0.0 &
scripts/minion-state-worker &
scripts/minion-scan-worker &
scripts/minion-plugin-worker &
scripts/minion-scanschedule-worker &
scripts/minion-scanscheduler &
sleep 5

# Create the initial administrator and database
scripts/minion-db-init "$MINION_ADMINISTRATOR_EMAIL" "$MINION_ADMINISTRATOR_NAME" y

# Follow some logs
tail -f /var/log/mongodb/mongodb.log /var/log/rabbitmq/*.log
