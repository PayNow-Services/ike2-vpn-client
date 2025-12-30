FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    strongswan \
    strongswan-charon \
    libcharon-extra-plugins \
    libstrongswan-extra-plugins \
    && rm -rf /var/lib/apt/lists/*

# Disable kernel-netlink, enable userspace kernel-libipsec
# Configure for userspace IPsec without kernel netlink
RUN echo "charon { \n\
  install_routes = no \n\
  install_virtual_ip = no \n\
  plugins { \n\
    kernel-netlink { \n\
      load = no \n\
    } \n\
    kernel-libipsec { \n\
      load = yes \n\
      allow_peer_ts = yes \n\
    } \n\
    kernel-pfkey { \n\
      load = no \n\
    } \n\
    forecast { \n\
      load = no \n\
    } \n\
    socket-default { \n\
      load = yes \n\
    } \n\
  } \n\
}" > /etc/strongswan.d/charon-custom.conf

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]