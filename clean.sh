#!/usr/bin/env bash

./kill.sh

echo ''
echo '[SQL-D]:CLEAN/'
echo ''
echo '  DESCRIPTION: '
echo '     This will nuke anything that has not been committed'
echo ''
echo '  USAGE: '
echo '     ./clean.sh'
echo ''

git clean -x -f -d

echo ''
echo '[SQL-D]:CLEAN/END/'
echo '	Success'
echo ''
