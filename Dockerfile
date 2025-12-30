FROM alpine:latest

RUN apk add --no-cache \
    strongswan \
    strongswan-charon \
    strongswan-kernel-libipsec

# Enable userspace IPsec
RUN echo -e "charon {\n  plugins {\n    kernel-libipsec {\n      load = yes\n    }\n  }\n}" > /etc/strongswan.d/kernel-libipsec.conf

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]