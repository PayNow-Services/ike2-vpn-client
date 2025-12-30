#!/bin/sh

# Ensure secrets file has correct permissions
chmod 600 /etc/ipsec.secrets

# Initialize NSS database
mkdir -p /var/lib/ipsec/nss
ipsec initnss 2>/dev/null || true

# Start pluto daemon in foreground
exec ipsec pluto --nofork