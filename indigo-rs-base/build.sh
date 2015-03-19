#!/bin/sh
# Author: Daniel Beßler

SCRIPT=`readlink -f "$0"`
DIR=`dirname $SCRIPT`

$DIR/../../scripts/start-apt-cacher
echo "Building knowrob/indigoo-kr-rs-base....";
docker build -t openease/indigo-kr-rs-base .

