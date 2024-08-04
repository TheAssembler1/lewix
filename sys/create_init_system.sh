#!/bin/bash

set -e
set -u

echo "creating init dir heiarchy"
mkdir -pv $LEWIX_MNT_ROOT_DIR/{etc,var} $LEWIX_MNT_ROOT_DIR/usr/{bin,lib,sbin}

echo "creating symlinks for bin lib sbin"
for i in bin lib sbin; do
    ln -sv usr/$i $LEWIX_MNT_ROOT_DIR/$i
done

echo "creating lib64 if x86_ 64"
case $(uname -m) in
    x86_64) mkdir -pv $LEWIX_MNT_ROOT_DIR/lib64 ;;
esac

echo "creating tools dir"
mkdir -pv $LEWIX_MNT_ROOT_DIR/tools

