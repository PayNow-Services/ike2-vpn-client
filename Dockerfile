FROM debian:sid-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    strongswan-starter \
    strongswan-charon \
    libcharon-extra-plugins \
    libstrongswan-extra-plugins \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Configure for userspace IPsec - disable kernel-netlink, enable libipsec
RUN echo "kernel-netlink { load = no }" > /etc/strongswan.d/charon/kernel-netlink.conf && \
    echo "kernel-libipsec { load = yes }" > /etc/strongswan.d/charon/kernel-libipsec.conf

# Create start script
RUN printf '#!/bin/sh\nchmod 600 /etc/ipsec.secrets\nexec ipsec start --nofork\n' > /start-vpn.sh && \
    chmod +x /start-vpn.sh

ENTRYPOINT ["/bin/sh", "/start-vpn.sh"]