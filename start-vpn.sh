#!/bin/sh

# Ensure secrets file has correct permissions
chmod 600 /etc/ipsec.secrets

# Initialize NSS database if needed
ipsec initnss 2>/dev/null || true

# Start pluto daemon in foreground
exec ipsec pluto --nofork