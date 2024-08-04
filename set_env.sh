#!/bin/bash

export LEWIX_ROOT_DIR=$(readlink -f .)
export LEWIX_VERSION=$(cat VERSION.txt)
export LEWIX_ISO_NAME="lewix_$LEWIX_VERSION.iso"
export LEWIX_MNT_DIR="$(readlink -f /mnt/lewix)"
export LEWIX_MNT_ROOT_DIR=$LEWIX_MNT_DIR/root
export LEWIX_MNT_ROOT_SRC_DIR=$LEWIX_MNT_ROOT_DIR/src
export LEWIX_MNT_ROOT_TOOLS_DIR=$LEWIX_MNT_ROOT_DIR/tools
export LEWIX_STATE_FILE="$(readlink -f $LEWIX_ROOT_DIR/STATE.txt)"
export LEWIX_TGT=$(uname -m)-lewix-linux-gnu

echo "LEWIX_ROOT_DIR: $LEWIX_ROOT_DIR"
echo "LEWIX_VERSION: $LEWIX_VERSION"
echo "LEWIX_ISO_NAME: $LEWIX_ISO_NAME"
echo "LEWIX_MNT_DIR: $LEWIX_MNT_DIR"
echo "LEWIX_MNT_ROOT_DIR: $LEWIX_MNT_ROOT_DIR"
echo "LEWIX_MNT_ROOT_SRC_DIR: $LEWIX_MNT_ROOT_SRC_DIR"
echo "LEWIX_MNT_ROOT_TOOLS_DIR: $LEWIX_MNT_ROOT_TOOLS_DIR"
echo "LEWIX_STATE_FILE: $LEWIX_STATE_FILE"
echo "LEWIX_TGT: $LEWIX_TGT"

lewix_state_get() {
    local key=$1
    grep "^${key}=" "$LEWIX_STATE_FILE" | cut -d'=' -f2
}

lewix_state_set() {
    local key=$1
    local value=$2

    if grep -q "^${key}=" "$LEWIX_STATE_FILE"; then
        awk -v key="$key" -v value="$value" -F '=' '
        $1 == key { $2 = value }
        { print }' "$LEWIX_STATE_FILE" > "$LEWIX_STATE_FILE.tmp" && mv "$LEWIX_STATE_FILE.tmp" "$LEWIX_STATE_FILE"
    else
        echo "$key=$value" >> "$LEWIX_STATE_FILE"
    fi
}

export -f lewix_state_get
export -f lewix_state_set
