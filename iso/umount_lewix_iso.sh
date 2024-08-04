#!/bin/bash

set -e 
set -u

echo "umounting boot dev"
sudo umount "$LEWIX_MNT_FOLDER/boot" || true
echo "umounting boot_efi dev"
sudo umount "$LEWIX_MNT_FOLDER/boot_efi" || true
echo "umounting swap dev"
sudo umount "$LEWIX_MNT_FOLDER/swap" || true
echo "umounting root dev"
sudo umount "$LEWIX_MNT_FOLDER/root" || true

echo "umounting $LEWIX_ISO_NAME"
sudo umount "$LEWIX_MNT_FOLDER/$LEWIX_ISO_NAME" || true

