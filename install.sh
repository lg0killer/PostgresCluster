#!/bin/sh


## Check if test network has been created before

if [ ! "$(docker network ls -q -f name=test)" ]; then
  echo "Creating network: test"
  docker network create test
else
  echo "Network test exists!"
fi


## Check if ports are available

if nc -w1 -z $(hostname) 15432; then
  echo "[ERROR] Port 15432 is currently in use"
  exit 1
fi

if nc -w1 -z $(hostname) 15433; then
  echo "[ERROR] Port 15433 is currently in use"
  exit 1
fi

echo "Ports 15432 & 15433 is available!"


echo "Starting postgrescluster stack"
## Create docker stack
docker-compose up -d
