#!/usr/bin/env bash

#TODO: this is too stupid, let's improve this
cp -f /code/sync.sh /hue/sync.sh
cp -f /code/run_server.sh /hue/run_server.sh
cp -f /code/desktop/conf/tubular.ini /hue/desktop/conf/pseudo-distributed.ini
cp -rf /code/apps/metastore/ /hue/apps/
