#!/bin/bash

set -e 
set -u

echo "umounting boot dev"
sudo umount "$LEWIX_MNT_DIR/boot" || true
echo "umounting boot_efi dev"
sudo umount "$LEWIX_MNT_DIR/boot_efi" || true
echo "umounting swap dev"
sudo umount "$LEWIX_MNT_DIR/swap" || true
echo "umounting root dev"
sudo umount "$LEWIX_MNT_DIR/root" || true

echo "umounting $LEWIX_ISO_NAME"
sudo umount "$LEWIX_MNT_DIR/$LEWIX_ISO_NAME" || true

