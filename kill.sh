#!/usr/bin/env bash

#set -x

echo ''
echo '[SQL-D]:KILL/'
echo ''
echo '  USAGE:'
echo '     KILL'
echo ''

pkill dotnet
pkill VBCSCompiler
pkill SqlD.UI
pkill SqlD.Start

echo ''
echo '[SQL-D]:KILL/END/'
echo '	Success'
echo ''
