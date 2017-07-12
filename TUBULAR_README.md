# Why
We made this fork to extend Hue UI with our custom logic of monitoring warehouse datasets health.

# Development

## Build
This will take a while (15-20min) so you don't want to execute this each time, also mounting volume makes it
too slow (couple hours) so we don't mount volumes from host system to build directory /hue.
We mount it sparately to /code.
```
docker-compose build dev
```
## Run dev shell
```
# start docker container
docker-compose run --service-ports dev /bin/bash

# run tmux (it's preinstalled) to run server
# and being able to perform other stuff like executing sync.sh
>> tmux
# (C-b % - to split windows, C-b <arrow Left, arrow Right> - to switch splits)

# run server, available at 0.0.0.0:9999, login with ldap credentials.
>> ./run_server.sh

# update code anytime you want, this will also automatically restart server
# Note: atm sync.sh only copies config ini file and apps/metastore which we modified
>> ./sync.sh

# advice: run only our tests, example:
>>./build/env/bin/hue test specific metastore.tests.metastore.views_test:TestViews.test_warehouse_healt
```
