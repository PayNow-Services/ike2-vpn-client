FROM debian:sid-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    charon-cmd \
    libcharon-extra-plugins \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Configure for userspace IPsec
RUN mkdir -p /etc/strongswan.d/charon-cmd && \
    printf '%s\n' \
    'charon-cmd {' \
    '  plugins {' \
    '    kernel-netlink { load = no }' \
    '    kernel-libipsec { load = yes }' \
    '  }' \
    '}' > /etc/strongswan.d/charon-cmd/custom.conf

# Create start script inline
RUN printf '#!/bin/sh\nexec charon-cmd --host "$VPN_HOST" --identity "$VPN_IDENTITY" --psk-file /etc/ipsec.d/psk.txt --ike-proposal aes256-sha256-modp2048 --esp-proposal aes256-sha256\n' > /start-vpn.sh && \
    chmod +x /start-vpn.sh

ENTRYPOINT ["/bin/sh", "/start-vpn.sh"]
