FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    strongswan \
    strongswan-charon \
    libcharon-extra-plugins \
    libstrongswan-extra-plugins \
    iproute2 \
    file \
    && rm -rf /var/lib/apt/lists/*

# Configure charon-cmd for userspace IPsec
RUN mkdir -p /etc/strongswan.d/charon-cmd && \
    printf '%s\n' \
    'charon-cmd {' \
    '  plugins {' \
    '    kernel-netlink { load = no }' \
    '    kernel-libipsec { load = yes }' \
    '  }' \
    '}' > /etc/strongswan.d/charon-cmd.conf

# Create start script inline
RUN printf '#!/bin/sh\necho "Testing..."\nwhich charon-cmd || echo "charon-cmd not found"\nfile /usr/bin/charon-cmd 2>/dev/null || file /usr/sbin/charon-cmd 2>/dev/null || echo "cannot find binary"\nsleep infinity\n' > /start-vpn.sh && \
    chmod +x /start-vpn.sh

ENTRYPOINT ["/bin/sh", "/start-vpn.sh"]