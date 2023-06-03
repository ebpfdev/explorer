#!/bin/bash
echo '{"agent_url": "/dev-agent"}' > /usr/share/nginx/html/config.json

nginx &
/app/dev-agent server --skip-welcome --path-prefix /dev-agent/ "$@" &

echo Started

wait -n
exit $?