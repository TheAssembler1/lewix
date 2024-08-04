#!/bin/bash

set -u
set -e

echo "unmounting partitions"
bash $LEWIX_ROOT_DIR/iso/umount_lewix_iso.sh || true
echo "removing loop dev"
bash $LEWIX_ROOT_DIR/iso/delete_loopback_dev.sh || true

echo "delete state file"
rm $LEWIX_STATE_FILE || true

echo "delete iso"
rm $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME || true

echo "removing mnt folders"
rm -vr $LEWIX_MNT_DIR/boot || true
rm -vr $LEWIX_MNT_DIR/boot_efi || true
rm -vr $LEWIX_MNT_DIR/swap || true
rm -vr $LEWIX_MNT_DIR/root || true
