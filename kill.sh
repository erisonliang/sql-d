#!/usr/bin/env bash

#set -x

echo ''
echo '[SQL-D]:KILL/'
echo ''

pkill dotnet
pkill VBCSCompiler
pkill SqlD.UI
pkill SqlD.Start
pkill SqlD.Start.osx-x64
pkill SqlD.Start.linux-x64
