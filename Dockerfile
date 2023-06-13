# syntax=docker/dockerfile:1

ARG AGENT_VERSION=v0.0.4
ARG UI_VERSION=v0.0.5

FROM ghcr.io/ebpfdev/explorer-ui:$UI_VERSION AS ui

FROM ghcr.io/ebpfdev/dev-agent:$AGENT_VERSION

RUN apt update
RUN apt install nginx -y

COPY --from=ui /usr/share/nginx/html /usr/share/nginx/html

COPY nginx.conf /etc/nginx/nginx.conf

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


