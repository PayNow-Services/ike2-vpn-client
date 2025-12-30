FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    strongswan \
    strongswan-charon \
    libcharon-extra-plugins \
    libstrongswan-extra-plugins \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

# Configure charon-cmd for userspace IPsec
RUN mkdir -p /etc/strongswan.d/charon-cmd && \
    echo "charon-cmd { \n\
  plugins { \n\
    kernel-netlink { load = no } \n\
    kernel-libipsec { load = yes } \n\
  } \n\
}" > /etc/strongswan.d/charon-cmd.conf

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]
