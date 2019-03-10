#!/usr/bin/env bash

docker build -t realorko/sql-d .
docker run -d -p 5000:5000 -t realorko/sql-d
docker-machine ls
docker-machine start father
eval $(docker-machine env father)
docker run -i -t realorko/sql-d:latest
