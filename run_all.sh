#!/bin/bash

set -e
set -u

bash iso/create_lewix_iso.sh
bash iso/create_loopback_dev.sh
bash sys/create_init_system.sh
