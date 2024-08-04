#!/bin/bash

set -e 
set -u

LOOPBACK_DEV=$(lewix_state_get "LOOPBACK_DEV")

echo "removing loopback dev"
losetup -d $LOOPBACK_DEV || true
