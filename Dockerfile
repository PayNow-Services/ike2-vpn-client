FROM alpine:latest

RUN apk add --no-cache strongswan

# Enable userspace IPsec
RUN sed -i 's/load = no/load = yes/' /etc/strongswan.d/charon/kernel-libipsec.conf 2>/dev/null || \
    echo "charon { plugins { kernel-libipsec { load = yes } } }" > /etc/strongswan.d/kernel-libipsec.conf

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]