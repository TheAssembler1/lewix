#!/bin/bash

set -e 
set -u

echo "creating mount points"
mkdir -vp "$LEWIX_MNT_DIR/boot"
mkdir -vp "$LEWIX_MNT_DIR/boot_efi"
mkdir -vp "$LEWIX_MNT_DIR/root"
mkdir -vp "$LEWIX_MNT_DIR/swap"

BOOT_LOOPBACK_DEV=$(lewix_state_get "BOOT_LOOPBACK_DEV")
BOOT_EFI_LOOPBACK_DEV=$(lewix_state_get "BOOT_EFI_LOOPBACK_DEV")
SWAP_LOOPBACK_DEV=$(lewix_state_get "SWAP_LOOPBACK_DEV")
ROOT_LOOPBACK_DEV=$(lewix_state_get "ROOT_LOOPBACK_DEV")

echo "mounting boot dev"
mount $BOOT_LOOPBACK_DEV "$LEWIX_MNT_DIR/boot"
echo "mounting boot_efi dev"
mount "$BOOT_EFI_LOOPBACK_DEV" "$LEWIX_MNT_DIR/boot_efi"
echo "creating swap dev"
swapon "$SWAP_LOOPBACK_DEV"
echo "mounting root dev"
mount "$ROOT_LOOPBACK_DEV" "$LEWIX_MNT_DIR/root"
