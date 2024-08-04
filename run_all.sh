#!/bin/bash

set -e
set -u

bash iso/create_lewix_iso.sh
bash iso/create_loopback_dev.sh
bash sys/create_init_system.sh
bash packages/install_packages.sh
bash packages/build_toolchain_and_temp_tools.sh
