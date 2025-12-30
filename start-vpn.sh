#!/bin/sh

# Ensure secrets file has correct permissions
chmod 600 /etc/ipsec.secrets

# Start strongSwan in foreground
exec ipsec start --nofork