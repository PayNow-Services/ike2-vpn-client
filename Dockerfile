FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    strongswan \
    strongswan-charon \
    libcharon-extra-plugins \
    && rm -rf /var/lib/apt/lists/*

# Disable kernel-netlink, enable userspace kernel-libipsec
RUN echo "kernel-netlink { load = no }" > /etc/strongswan.d/charon/kernel-netlink.conf && \
    echo "kernel-libipsec { load = yes }" > /etc/strongswan.d/charon/kernel-libipsec.conf && \
    echo "socket-default { load = yes }" > /etc/strongswan.d/charon/socket-default.conf

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]