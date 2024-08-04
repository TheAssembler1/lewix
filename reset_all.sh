#!/bin/bash

echo "unmounting partitions"
bash $LEWIX_ROOT_DIR/iso/umount_lewix_iso.sh
echo "removing loop dev"
bash $LEWIX_ROOT_DIR/iso/delete_loopback_dev.sh

echo "delete state file"
rm $LEWIX_STATE_FILE

echo "delete iso"
rm $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME

echo "removing mnt folders"
rm -vr $LEWIX_MNT_DIR/boot
rm -vr $LEWIX_MNT_DIR/boot_efi
rm -vr $LEWIX_MNT_DIR/swap
rm -vr $LEWIX_MNT_DIR/root
