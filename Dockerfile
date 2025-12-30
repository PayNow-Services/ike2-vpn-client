FROM alpine:latest

RUN apk add --no-cache libreswan

COPY start-vpn.sh /start-vpn.sh
RUN chmod +x /start-vpn.sh

ENTRYPOINT ["/start-vpn.sh"]