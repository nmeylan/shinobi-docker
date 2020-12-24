#!/bin/sh
set -e

if [ ! -e "./conf.json" ]; then
    echo "Creating conf.json"
    sudo cp conf.sample.json conf.json
else
    echo "conf.json already exists..."
fi
cd /home/shinobi-plugins/yolo
if [ -e "/config/conf.json" ]; then
    sudo cp /config/conf.json conf.json
fi
if [ ! -e "./conf.json" ]; then
    sudo cp conf.sample.json conf.json
fi
if [ "$PLUGIN_KEY" = "RANDOM" ]; then
    newPluginKey="$(head -c 64 < /dev/urandom | sha256sum | awk '{print substr($1,1,60)}')"
else
    newPluginKey="$PLUGIN_KEY"
fi
node ./modifyConfigurationForPlugin.js yolo key=$newPluginKey plug=$PLUGIN_NAME host=$PLUGIN_HOST port=$PLUGIN_PORT mode=$PLUGIN_MODE hostPort=$PLUGIN_HOST_PORT maxRetryConnection=100
echo "Plugin key to be added to Shinobi conf.json is : "
echo "\"$PLUGIN_NAME\":\"$newPluginKey\""
sudo cp conf.json /config/conf.json

# Execute Command
echo "Starting $PLUGIN_NAME plugin for Shinobi ..."
exec "$@"
