#!/bin/bash
set -e

# if [ ! "$(ls -A /opt/magic_mirror/modules)" ]; then
#     echo "Found no modules. Using "
#     cp -Rn /opt/default_modules/. /opt/magic_mirror/modules
# fi

if [ ! -f "/opt/magic_mirror/config/config.js" ]; then
    echo "Found no config. Using default"
    cp /opt/magic_mirror/mm-config.js /opt/magic_mirror/config/config.js
fi

# if [ -f "/opt/magic_mirror/config/config.js.template" ]; then
#     echo "Found config template."
#     envsubst < /opt/magic_mirror/config/config.js.template > /opt/magic_mirror/config/config.js
# fi

cd /opt/magic_mirror/modules/MMM-Face-Reco-DNN/tools

python3 encode.py -i /opt/data/ -e encodings.pickle -d hog

cd /opt/magic_mirror

exec "$@"