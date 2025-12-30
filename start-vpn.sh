exec charon-cmd \
    --host "$VPN_HOST" \
    --identity "$VPN_IDENTITY" \
    --psk-file /etc/ipsec.d/psk.txt \
    --ike-proposal aes256-sha256-modp2048 \
    --esp-proposal aes256-sha256
