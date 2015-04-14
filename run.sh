#!/usr/bin/env bash

# Start MongoDB
mongod --fork --logpath /var/log/mongodb/mongodb.log
sleep 5

# Start RabbitMQ
rabbitmq-server -detached
sleep 5

# Start Minion
cd $MINION_BACKEND
scripts/minion-backend-api runserver &
scripts/minion-state-worker &
scripts/minion-scan-worker &
scripts/minion-plugin-worker &
scripts/minion-scanschedule-worker &
scripts/minion-scanscheduler &

# Follow some logs
tail -f /var/log/mongodb/mongodb.log /var/log/rabbitmq/*.log
