#!/bin/sh

chmod 600 /etc/ipsec.secrets

exec ipsec start --nofork