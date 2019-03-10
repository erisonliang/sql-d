#!/usr/bin/env bash

echo "[SQL-D]: Please make sure you have run:"
echo "[SQL-D]:  - docker-machine create father"
echo "[SQL-D]:  - eval $(docker-machine env father)"

docker build -t realorko/sql-d .
docker run -d -p 5000:5000 -t realorko/sql-d
docker-machine ls
docker-machine start father
eval $(docker-machine env father)
docker run -t realorko/sql-d:latest -p 5000:5000

echo "[SQL-D]: This will try and start a new sql-d.start.linux-x64 instance"
