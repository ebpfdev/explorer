# syntax=docker/dockerfile:1

ARG AGENT_VERSION=main
ARG UI_VERSION=main

FROM ghcr.io/ebpfdev/explorer-ui:$UI_VERSION AS ui

FROM ghcr.io/ebpfdev/dev-agent:$AGENT_VERSION

RUN apt update
RUN apt install nginx -y

COPY --from=ui /usr/share/nginx/html /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

COPY <<EOF /start.sh
#!/bin/bash
echo '{"agent_url": "/dev-agent"}' > /usr/share/nginx/html/config.json

nginx &
/app/dev-agent server --skip-welcome --path-prefix /dev-agent/ &
wait -n
exit $?
EOF

RUN chmod +x /start.sh

CMD ["/start.sh"]


