#!/bin/bash

set -e
set -u

echo "creating loopback devices for partitions"
LOOPBACK_DEV=$(losetup -f --show -P "$LEWIX_ROOT_DIR/$LEWIX_ISO_NAME") 
LOOPBACK_DEV_BASE="/dev/$(basename "$LOOPBACK_DEV")"

echo "verifying loop device partitions"
lsblk -f

echo "writing loopback dev to $LEWIX_STATE_FILE"
lewix_state_set "LOOPBACK_DEV" "${LOOPBACK_DEV_BASE}"
lewix_state_set "BOOT_LOOPBACK_DEV" "${LOOPBACK_DEV_BASE}p1"
lewix_state_set "BOOT_EFI_LOOPBACK_DEV" "${LOOPBACK_DEV_BASE}p2"
lewix_state_set "SWAP_LOOPBACK_DEV" "${LOOPBACK_DEV_BASE}p3"
lewix_state_set "ROOT_LOOPBACK_DEV" "${LOOPBACK_DEV_BASE}p4"

echo "formatting loopback partitions"
mkfs.ext4 "${LOOPBACK_DEV_BASE}p1"
mkfs.vfat "${LOOPBACK_DEV_BASE}p2"
mkswap "${LOOPBACK_DEV_BASE}p3"
mkfs.ext4 "${LOOPBACK_DEV_BASE}p4"

echo "listing loop devices and partitions"
lsblk

