#!/bin/bash

set -u
set -e

echo "creating $LEWIX_ISO_NAME"
dd if=/dev/zero of="$LEWIX_ROOT_DIR/$LEWIX_ISO_NAME" bs=1M count=32768 status=progress

echo "creating $LEWIX_ISO_NAME gpt"
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script mklabel gpt

echo "creating $LEWIX_ISO_NAME partitions"
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script mkpart primary ext4 1MiB 512MiB
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script name 1 boot
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script mkpart primary fat32 512Mib 1Gib
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script name 2 boot_efi
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script mkpart primary linux-swap 1Gib 3Gib
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script name 3 swap
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script mkpart primary ext4 3Gib 100%
parted $LEWIX_ROOT_DIR/$LEWIX_ISO_NAME --script name 4 root
