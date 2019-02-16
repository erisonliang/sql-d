#!/usr/bin/env bash

docker build -t cryosharp/sql-d .
docker run -d -p 5000:5000 -p 50095:50095 -p 50100:50100 -p 50101:50101 -p 50102:50102 -p 50103:50103 -t cryosharp/sql-d
docker-machine ls
