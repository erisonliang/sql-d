#!/usr/bin/env bash

./kill.sh

echo ''
echo '[SQL-D]:CLEAN/'
echo ''

git clean -x -f -d
