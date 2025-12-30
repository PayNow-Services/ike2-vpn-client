FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    libreswan \
    iproute2 \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /run/pluto /var/run/pluto

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]