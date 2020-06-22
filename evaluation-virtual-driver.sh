#!/usr/bin/env bash

USAGE="
  ./this_script.sh <driver_ip_subnet> <driver_port>
"

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "$USAGE"
    exit 1
fi

######### Update driver ip and port

#SUBNET=$1
DRIVER_IP='0.0.0.0'
NEW_PORT=$2

pushd config

cp config.js.sample config.js
sed -i "s/address: \"localhost\"/address: \"$DRIVER_IP\"/g" config.js
sed -i "s/port: 8080/port: $NEW_PORT/g" config.js
sed -i "s/\/\/ serverOnly:  true\/false\/\"local\" ,/serverOnly: true,/g" config.js
sed -i "s/ipWhitelist: \[/ipWhitelist: \[\"$DRIVER_IP\/24\", /g" config.js

popd # config/ dir

######## Start webserver
npm start
